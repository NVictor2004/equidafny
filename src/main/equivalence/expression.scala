package equivalence.expression

import translation.structure.*

import equivalence.program.functionEquivalence

private def lookup[A, B](data: List[(A, B)], key: A): B =
    data.find((a, _) => a == key).get._2

def mergeBasicExpr(currentLemmas: Map[String, Lemma], modelExpr: BasicExpr, modelFunc: Function, candidateExpr: BasicExpr, candidateFunc: Function)(using program: Program): (Map[String, Lemma], List[(String, String)], List[Stmt]) = 
    (modelExpr, candidateExpr) match {
        case (TrueFunctionCall(calledInModel, calledInModelArgs), TrueFunctionCall(calledInCandidate, calledInCandidateArgs))
            if calledInModel != modelFunc.name && calledInCandidate != candidateFunc.name && calledInModelArgs.map(_.length).sum == calledInCandidateArgs.map(_.length).sum => {
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
            val finalStmt = CallStmt(lemma._2.name, calledInModelArgs.map(_.map((_, expr) => expr).toList))

            (helperLemmas + lemma, finalMapping, List(finalStmt))
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
        case (Binary(modelOp, modelLeft, modelRight), Binary(candOp, candLeft, candRight)) if modelOp == candOp => {
            val (leftLemmas, leftMappings, leftStmts) = mergeBasicExpr(currentLemmas, modelLeft, modelFunc, candLeft, candidateFunc)
            val (rightLemmas, rightMappings, rightStmts) = mergeBasicExpr(leftLemmas, modelRight, modelFunc, candRight, candidateFunc)
            (rightLemmas, leftMappings ++ rightMappings, leftStmts ++ rightStmts)
        }
        case (Ident(modelName, Nil), Ident(candName, Nil)) => {
            (currentLemmas, List(modelName -> candName), Nil)
        }
        case _ => (currentLemmas, Nil, Nil)
    }

def mergeExprBlock(currentLemmas: Map[String, Lemma], modelExprBlock: ExprBlock, modelFunc: Function, candidateExprBlock: ExprBlock, candidateFunc: Function)(using program: Program): (Map[String, Lemma], List[(String, String)], List[Stmt]) = {
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

def mergeFunction(currentLemmas: Map[String, Lemma], modelFunc: Function, candidateFunc: Function)(using program: Program): (Map[String, Lemma], List[(String, String)], List[Stmt]) = {
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