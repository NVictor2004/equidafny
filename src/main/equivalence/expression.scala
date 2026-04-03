package equivalence.expression

import translation.structure.*

import equivalence.program.{functionEquivalence, generateLemmaName}
import equivalence.pattern.{getIdentsFromPattern, listContainsUnNamed}

private def lookup[A, B](data: List[(A, B)], key: A): B =
    data.find((a, _) => a == key).get._2

private def numberOfArguments[A](data: List[List[A]]): Int = data.map(_.length).sum

def mergeBasicExpr(currentLemmas: Map[String, Option[Lemma]], modelExpr: BasicExpr, modelFunc: Function, candidateExpr: BasicExpr, candidateFunc: Function)(using program: Program): (Map[String, Option[Lemma]], List[(String, String)], List[Stmt]) = 
    (modelExpr, candidateExpr) match {
        case (TrueFunctionCall(calledInModel, calledInModelArgs), TrueFunctionCall(calledInCandidate, calledInCandidateArgs))
        if calledInModel != modelFunc.name && calledInCandidate != candidateFunc.name && numberOfArguments(calledInModelArgs) == numberOfArguments(calledInCandidateArgs) => 
            currentLemmas.get(calledInModel) match {
                case None => {
                    // This pair of functions has not been encountered yet, generate its equivalence lemma

                    // Generate Equivalence data for the called functions
                    val funcCalledInModel = program.helperFunctions(calledInModel)
                    val funcCalledInCandidate = program.helperFunctions(calledInCandidate)
                    val (lemma, helperLemmas, mapping) = functionEquivalence(currentLemmas, funcCalledInModel, funcCalledInCandidate)

                    // Convert mapping between the parameters of the called functions to a mapping to the parameters in
                    // the caller functions
                    val finalMapping = mapping.map {
                        case (modelName, candName) => lookup(calledInModelArgs(0), modelName) -> lookup(calledInCandidateArgs(0), candName)
                    }.collect {
                        case (Ident(name, Nil), Ident(name2, Nil)) => name -> name2
                    }

                    // Call the generated helper equivalence lemma
                    val finalStmt = CallStmt(generateLemmaName(calledInModel, calledInCandidate), calledInModelArgs.map(_.map((_, expr) => expr).toList))

                    (helperLemmas + lemma, finalMapping, List(finalStmt))
                }
                case Some(None) => {
                    // This pair of functions has been encountered before, but we are currently in the process
                    // of generating its equivalence lemma
                    // Just call the lemma without trying to generate it, trust that it will get generated before the whole
                    // merging process completes

                    val finalStmt = CallStmt(generateLemmaName(calledInModel, calledInCandidate), calledInModelArgs.map(_.map((_, expr) => expr).toList))
                    (currentLemmas, Nil, List(finalStmt))
                }
                case Some(Some(lemma)) => {
                    // This pair of functions has been encountered before, and its equivalence lemma has already
                    // been generated, just call it

                    val finalStmt = CallStmt(lemma.name, calledInModelArgs.map(_.map((_, expr) => expr).toList))
                    (currentLemmas, Nil, List(finalStmt))
                }
            }
        case (OtherFunctionCall(calledInModel, calledInModelArgs), OtherFunctionCall(calledInCand, calledInCandArgs)) if calledInModel == calledInCand => {
            val flattened = calledInModelArgs.zip(calledInCandArgs).flatMap((modelList, candList) => modelList.zip(candList))
            flattened.foldLeft((currentLemmas, Nil, Nil)) {
                case ((accLemmas, accMappings, accStmts), (modelExpr, candExpr)) => {
                    val (lemmas, mappings, stmts) = mergeBasicExpr(accLemmas, modelExpr, modelFunc, candExpr, candidateFunc)
                    (lemmas, accMappings ++ mappings, accStmts ++ stmts)
                }
            }
        }
        case (Cond(modelCond, modelThen, modelElse), Cond(candidateCond, candidateThen, candidateElse)) => {
            val (condLemmas, condMappings, condStmts) = mergeBasicExpr(currentLemmas, modelCond, modelFunc, candidateCond, candidateFunc)
            val (thenLemmas, thenMappings, thenStmts) = mergeExprBlock(condLemmas, modelThen, modelFunc, candidateThen, candidateFunc)
            val (elseLemmas, elseMappings, elseStmts) = mergeExprBlock(thenLemmas, modelElse, modelFunc, candidateElse, candidateFunc)

            val finalStmts = (thenStmts, elseStmts) match {
                case (Nil, Nil) => condStmts
                case _ => condStmts ++ List(CondStmt(modelCond, BlockStmt(thenStmts), Some(BlockStmt(elseStmts))))
            }

            // TODO: Mappings concatenation
            (elseLemmas, condMappings ++ thenMappings ++ elseMappings, finalStmts)
        }
        case (Tuple(modelElements), Tuple(candElements)) if modelElements.length == candElements.length => {
            modelElements.zip(candElements).foldLeft((currentLemmas, Nil, Nil)) {
                case ((accLemmas, accMappings, accStmts), (modelElem, candElem)) => {
                    val (lemmas, mappings, stmts) = mergeBasicExpr(accLemmas, modelElem, modelFunc, candElem, candidateFunc)
                    (lemmas, accMappings ++ mappings, accStmts ++ stmts)
                }
            }
        }
        case (Binary(modelOp, 
                     modelLeft @ TrueFunctionCall(_, modelLeftArgs), modelRight @ TrueFunctionCall(_, modelRightArgs)),
              Binary(candOp,
                     candLeft @ TrueFunctionCall(_, candLeftArgs), candRight @ TrueFunctionCall(_, candRightArgs)))
              if modelOp == candOp &&
                 numberOfArguments(modelLeftArgs) == numberOfArguments(candRightArgs) && 
                 numberOfArguments(modelRightArgs) == numberOfArguments(candLeftArgs) &&
                 numberOfArguments(modelLeftArgs) != numberOfArguments(candLeftArgs) &&
                 numberOfArguments(modelRightArgs) != numberOfArguments(candRightArgs) => {
            val (leftLemmas, leftMappings, leftStmts) = mergeBasicExpr(currentLemmas, modelLeft, modelFunc, candRight, candidateFunc)
            val (rightLemmas, rightMappings, rightStmts) = mergeBasicExpr(leftLemmas, modelRight, modelFunc, candLeft, candidateFunc)
            (rightLemmas, leftMappings ++ rightMappings, leftStmts ++ rightStmts)
        }
        case (Binary(modelOp, modelLeft, modelRight), Binary(candOp, candLeft, candRight)) if modelOp == candOp => {
            val (leftLemmas, leftMappings, leftStmts) = mergeBasicExpr(currentLemmas, modelLeft, modelFunc, candLeft, candidateFunc)
            val (rightLemmas, rightMappings, rightStmts) = mergeBasicExpr(leftLemmas, modelRight, modelFunc, candRight, candidateFunc)
            (rightLemmas, leftMappings ++ rightMappings, leftStmts ++ rightStmts)
        }
        case (Unary(modelOp, modelExpr), Unary(candOp, candExpr)) if modelOp == candOp => 
            mergeBasicExpr(currentLemmas, modelExpr, modelFunc, candExpr, candidateFunc)

        case (Ident(modelName, Nil), Ident(candName, Nil)) =>
            (currentLemmas, List(modelName -> candName), Nil)

        // TODO: When the match expressions have different numbers of cases
        // TODO: When they have the same number, but are in a different order
        case (Match(modelExpr, modelCases), Match(candExpr, unsortedCandCases)) if modelCases.length == unsortedCandCases.length && listContainsUnNamed(modelCases.map(_._1)) == listContainsUnNamed(unsortedCandCases.map(_._1)) => {
            val candCases = 
                if listContainsUnNamed(modelCases.map(_._1)) then unsortedCandCases
                else modelCases.map((modelPattern, _) => unsortedCandCases.find(_._1 == modelPattern).get)
                
            val (exprLemmas, exprMappings, exprStmts) = mergeBasicExpr(currentLemmas, modelExpr, modelFunc, candExpr, candidateFunc)
            val (finalLemmas, finalMappings, stmts) = modelCases.zip(candCases).foldLeft(((exprLemmas, exprMappings, List[List[Stmt]]()))) {
                case ((accLemmas, accMappings, accStmts), ((modelPattern, modelExprBlock), (_, candExprBlock))) => {
                    val (lemmas, mappings, stmts) = mergeExprBlock(accLemmas, modelExprBlock, modelFunc, candExprBlock, candidateFunc)
                    val identsInModelPattern = getIdentsFromPattern(modelPattern)
                    val filteredMappings = mappings.filterNot((model, _) => identsInModelPattern.contains(model))
                    (lemmas, accMappings ++ filteredMappings, accStmts :+ stmts)
                }
            }
            val allEmpty = stmts.foldLeft(true)((acc, stmts) => acc && stmts.isEmpty)
            val finalStmts = if allEmpty then exprStmts else exprStmts :+ MatchStmt(modelExpr, modelCases.map(_._1).zip(stmts))

            (finalLemmas, finalMappings, finalStmts)
        }
        case _ => (currentLemmas, Nil, Nil)
    }

def mergeExprBlock(currentLemmas: Map[String, Option[Lemma]], modelExprBlock: ExprBlock, modelFunc: Function, candidateExprBlock: ExprBlock, candidateFunc: Function)(using program: Program): (Map[String, Option[Lemma]], List[(String, String)], List[Stmt]) = {
    val ExprBlock(modelExtended, modelBasic) = modelExprBlock
    val ExprBlock(_, candBasic) = candidateExprBlock

    val (lemmas, mappings, stmts) = mergeBasicExpr(currentLemmas, modelBasic, modelFunc, candBasic, candidateFunc)

    val modelVariables = stmts match {
        case Nil => Nil
        case _ => modelExtended.collect {
            case Let(left, right) => LetStmt(left.map(_._1), right)
        }
    }

    (lemmas, mappings, modelVariables ++ stmts)
}

def mergeFunction(currentLemmas: Map[String, Option[Lemma]], modelFunc: Function, candidateFunc: Function)(using program: Program): (Map[String, Option[Lemma]], List[(String, String)], List[Stmt]) = {
    // Mappings are generated through merging the function bodys and through type matching
    val (lemmas, mappings, stmts) = mergeExprBlock(currentLemmas, modelFunc.body, modelFunc, candidateFunc.body, candidateFunc)

    // Find parameters not covered by function body merging
    val modelParamsCovered = mappings.map(_._1)
    val candParamsCovered = mappings.map(_._2)

    val modelParamsLeft = modelFunc.params.filterNot(param => modelParamsCovered.contains(param.name))
    var candParamsLeft = candidateFunc.params.filterNot(param => candParamsCovered.contains(param.name))

    // Generate type mappings
    val typeMappings = modelParamsLeft.map(modelParameter => {
        val candParam = candParamsLeft.find(param => param.paramType == modelParameter.paramType).get
        candParamsLeft = candParamsLeft.filter(_ != candParam)
        (modelParameter.name, candParam.name)
    }).toList

    (lemmas, mappings ++ typeMappings, stmts)
}