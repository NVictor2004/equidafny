package equivalence.expression

import translation.structure.*

import equivalence.program.{functionEquivalence, generateLemmaName}
import equivalence.pattern.*
import scala.collection.immutable.ListMap
import scala.collection.mutable.Map as MutableMap

private def lookup[A, B](data: List[(A, B)], key: A): B =
    data.find((a, _) => a == key).get._2

private def numberOfArguments[A](data: List[List[A]]): Int = data.map(_.length).sum

def mergeBasicExpr(currentLemmas: MutableMap[String, Option[Lemma]], currentMappings: Map[String, String], modelExpr: BasicExpr, modelFunc: Function, candidateExpr: BasicExpr, candidateFunc: Function)(using program: Program): (Map[String, String], List[Stmt]) = {
    val (unfilteredMappings, finalStmts) = (modelExpr, candidateExpr) match {
        case (TrueFunctionCall(calledInModel, calledInModelArgs), TrueFunctionCall(calledInCandidate, calledInCandidateArgs))
        if calledInModel != modelFunc.name && calledInCandidate != candidateFunc.name && calledInModel != calledInCandidate && numberOfArguments(calledInModelArgs) == numberOfArguments(calledInCandidateArgs) && !currentLemmas.get(calledInModel).isDefined => {
            // This pair of functions has not been encountered yet, generate its equivalence lemma

            // Generate Equivalence data for the called functions
            val funcCalledInModel = program.helperFunctions(calledInModel)
            val funcCalledInCandidate = program.helperFunctions(calledInCandidate)
            val (lemma, mapping) = functionEquivalence(currentLemmas, funcCalledInModel, funcCalledInCandidate)

            // Convert mapping between the parameters of the called functions to a mapping to the parameters in
            // the caller functions
            val finalMapping = mapping.map {
                case (candName, modelName) => lookup(calledInCandidateArgs(0), candName) -> lookup(calledInModelArgs(0), modelName)
            }.collect {
                case (Ident(name, Nil), Ident(name2, Nil)) => name -> name2
            }

            // Call the generated helper equivalence lemma
            val finalStmt = CallStmt(generateLemmaName(calledInModel, calledInCandidate), List(calledInModelArgs(0).map(_._2)))

            currentLemmas += lemma
            (currentMappings ++ finalMapping, List(finalStmt))
        }
        case (TrueFunctionCall(calledInModel, calledInModelArgs), TrueFunctionCall(calledInCandidate, calledInCandidateArgs))
        if calledInModel != calledInCandidate && numberOfArguments(calledInModelArgs) == numberOfArguments(calledInCandidateArgs) => {
            val exprMapping = currentMappings.map {
                case (candName, modelName) => lookup(calledInCandidateArgs(0), candName) -> lookup(calledInModelArgs(0), modelName)
            }

            // TODO: Match function arguments to generate further mappings for all cases where two functions are compared
            val (finalMappings, stmts) = exprMapping.foldLeft((currentMappings, List[Stmt]())) {
                case ((accMappings, accStmts), (candExpr, modelExpr)) => {
                    val (mappings, stmts) = mergeBasicExpr(currentLemmas, accMappings, modelExpr, modelFunc, candExpr, candidateFunc)
                    (mappings, accStmts ++ stmts)
                }
            }

            val finalStmt = CallStmt(generateLemmaName(calledInModel, calledInCandidate), List(calledInModelArgs(0).map(_._2)))

            (finalMappings, stmts :+ finalStmt)
        }
        case (OtherFunctionCall(calledInModel, calledInModelArgs), OtherFunctionCall(calledInCand, calledInCandArgs)) if calledInModel == calledInCand => {
            val flattened = calledInModelArgs.zip(calledInCandArgs).flatMap((modelList, candList) => modelList.zip(candList))
            flattened.foldLeft((currentMappings, List[Stmt]())) {
                case ((accMappings, accStmts), (modelExpr, candExpr)) => {
                    val (mappings, stmts) = mergeBasicExpr(currentLemmas, accMappings, modelExpr, modelFunc, candExpr, candidateFunc)
                    (mappings, accStmts ++ stmts)
                }
            }
        }
        case (Cond(modelCond, modelThen, modelElse), Cond(candidateCond, candidateThen, candidateElse)) => {
            val (condMappings, condStmts) = mergeBasicExpr(currentLemmas, currentMappings, modelCond, modelFunc, candidateCond, candidateFunc)
            val (thenMappings, thenStmts) = mergeExprBlock(currentLemmas, condMappings, modelThen, modelFunc, candidateThen, candidateFunc)
            val (elseMappings, elseStmts) = mergeExprBlock(currentLemmas, thenMappings, modelElse, modelFunc, candidateElse, candidateFunc)

            val finalStmts = (thenStmts, elseStmts) match {
                case (Nil, Nil) => condStmts
                case _ => condStmts ++ List(CondStmt(modelCond, BlockStmt(thenStmts), Some(BlockStmt(elseStmts))))
            }

            (elseMappings, finalStmts)
        }
        // TODO: Same length tuples? In which case, the match expression pattern matching needs to be fixed
        case (Tuple(modelElements), Tuple(candElements)) => {
            modelElements.zip(candElements).foldLeft((currentMappings, List[Stmt]())) {
                case ((accMappings, accStmts), (modelElem, candElem)) => {
                    val (mappings, stmts) = mergeBasicExpr(currentLemmas, accMappings, modelElem, modelFunc, candElem, candidateFunc)
                    (mappings, accStmts ++ stmts)
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
            val (leftMappings, leftStmts) = mergeBasicExpr(currentLemmas, currentMappings, modelLeft, modelFunc, candRight, candidateFunc)
            val (rightMappings, rightStmts) = mergeBasicExpr(currentLemmas, leftMappings, modelRight, modelFunc, candLeft, candidateFunc)
            (rightMappings, leftStmts ++ rightStmts)
        }
        case (Binary(modelOp, modelLeft, modelRight), Binary(candOp, candLeft, candRight)) if modelOp == candOp => {
            val (leftMappings, leftStmts) = mergeBasicExpr(currentLemmas, currentMappings, modelLeft, modelFunc, candLeft, candidateFunc)
            val (rightMappings, rightStmts) = mergeBasicExpr(currentLemmas, leftMappings, modelRight, modelFunc, candRight, candidateFunc)
            (rightMappings, leftStmts ++ rightStmts)
        }
        case (Unary(modelOp, modelExpr), Unary(candOp, candExpr)) if modelOp == candOp => 
            mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc)

        case (Ident(modelName, Nil), Ident(candName, Nil)) =>
            (currentMappings + (candName -> modelName), Nil)

        // TODO: When the match expressions have different numbers of cases
        // TODO: When they have the same number, but are in a different order
        // TODO: If variables introduced in a match pattern have the same names as parameters, both will be removed
        case (Match(modelExpr, modelCases), Match(candExpr, unsortedCandCases)) if modelCases.length == unsortedCandCases.length && listContainsUnNamed(modelCases.map(_._1)) == listContainsUnNamed(unsortedCandCases.map(_._1)) => {
            val candCases = 
                if listContainsUnNamed(modelCases.map(_._1)) then unsortedCandCases
                else modelCases.map((modelPattern, _) => unsortedCandCases.find(_._1 == modelPattern).get)
                
            val (exprMappings, exprStmts) = mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc)
            val (finalMappings, stmts) = modelCases.zip(candCases).foldLeft(((exprMappings, List[List[Stmt]]()))) {
                case ((accMappings, accStmts), ((modelPattern, modelExprBlock), (_, candExprBlock))) => {
                    val (mappings, stmts) = mergeExprBlock(currentLemmas, accMappings, modelExprBlock, modelFunc, candExprBlock, candidateFunc)
                    val identsInModelPattern = getIdentsFromPattern(modelPattern)
                    val filteredMappings = mappings.filterNot((_, model) => identsInModelPattern.contains(model))
                    (filteredMappings, accStmts :+ stmts)
                }
            }
            val allEmpty = stmts.foldLeft(true)((acc, stmts) => acc && stmts.isEmpty)
            val finalStmts = if allEmpty then exprStmts else exprStmts :+ MatchStmt(modelExpr, modelCases.map(_._1).zip(stmts))

            (finalMappings, finalStmts)
        }
        case (Match(modelExpr, modelCases), Match(candExpr, candCases)) => {
            val (exprMappings, exprStmts) = mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc)

            // Create mappings between the identifiers in the model match expression's expression and each model case's pattern
            val modelPatternMappings = modelCases.map((pattern, _) => mapBasicExprToPattern(modelExpr, pattern))

            // For each model case, create a pattern to merge with every candidate case
            val modelPatterns = modelPatternMappings.map(patternMappings => createPattern(candExpr, exprMappings, patternMappings))

            val candExprBlocks = modelPatterns.map(modelPattern => candCases.filter(candCase => mergePattern(modelPattern, candCase._1)).map(_._2))
            val exprBlockMappings = modelCases.map(_._2).zip(candExprBlocks)

            val (finalMappings, stmts) = exprBlockMappings.foldLeft((exprMappings, List[List[Stmt]]())) {
                case ((accMappings, accStmts), (modelExprBlock, candExprBlocks)) => {
                    val (mappings, stmts) = candExprBlocks.foldLeft((accMappings, List[Stmt]())) {
                        case ((accMappings, accStmts), candExprBlock) => {
                            val (mappings, stmts) = mergeExprBlock(currentLemmas, accMappings, modelExprBlock, modelFunc, candExprBlock, candidateFunc)
                            (mappings, accStmts ++ stmts)
                        }
                    }
                    (mappings, accStmts :+ stmts)
                }
            }

            val finalStmts = exprStmts :+ MatchStmt(modelExpr, modelCases.map(_._1).zip(stmts))
            (finalMappings, finalStmts)
        }
        case _ => (currentMappings, Nil)
    }

    val modelParamNames = modelFunc.params.map(_._1).toList
    val finalMappings = unfilteredMappings.filter((_, modelName) => modelParamNames.contains(modelName))
    (finalMappings, finalStmts)
}

def mergeExprBlock(currentLemmas: MutableMap[String, Option[Lemma]], currentMappings: Map[String, String], modelExprBlock: ExprBlock, modelFunc: Function, candidateExprBlock: ExprBlock, candidateFunc: Function)(using program: Program): (Map[String, String], List[Stmt]) = {
    val ExprBlock(modelExtended, modelBasic) = modelExprBlock
    val ExprBlock(_, candBasic) = candidateExprBlock

    val (mappings, stmts) = mergeBasicExpr(currentLemmas, currentMappings, modelBasic, modelFunc, candBasic, candidateFunc)

    val modelVariables = stmts match {
        case Nil => Nil
        case _ => modelExtended.collect {
            case Let(left, right) => LetStmt(left.map(_._1), right)
        }
    }

    (mappings, modelVariables ++ stmts)
}

def mergeFunction(currentLemmas: MutableMap[String, Option[Lemma]], modelFunc: Function, candidateFunc: Function)(using program: Program): (Map[String, String], List[Stmt]) = {
    // Mappings are generated through merging the function bodys and through type matching

    // Find Type mappings
    val modelTypeCounts = mapTypesToCounts(modelFunc.params)
    val candTypeCounts = mapTypesToCounts(candidateFunc.params)

    val typeMappings = modelTypeCounts.foldLeft(List[(String, String)]()) {
        case (accMappings, (paramType, modelCount)) => {
            val candCount = candTypeCounts.getOrElse(paramType, 0)
            if (modelCount != candCount) {
                throw new IllegalArgumentException("Types can't be matched")
            }
            if (modelCount == 1) {
                val modelName = modelFunc.params.find((_, currentType) => currentType == paramType).get._1
                val candName = candidateFunc.params.find((_, currentType) => currentType == paramType).get._1
                accMappings ++ List((candName, modelName))
            } else {
                accMappings
            }
        }
    }.toMap

    // Find mappings through function body merging
    val (mappings, stmts) = mergeExprBlock(currentLemmas, typeMappings, modelFunc.body, modelFunc, candidateFunc.body, candidateFunc)

    // Find parameters not covered already
    val candParamsCovered = mappings.keys.toList
    val modelParamsCovered = mappings.values.toList

    val modelParamsLeft = modelFunc.params.filterNot((name, _) => modelParamsCovered.contains(name))
    var candParamsLeft = candidateFunc.params.filterNot((name, _) => candParamsCovered.contains(name))

    // Generate remaining mappings
    val remainingMappings = modelParamsLeft.map((modelName, modelType) => {
        val (candName, _) = candParamsLeft.find((_, currentType) => currentType == modelType).get
        candParamsLeft = candParamsLeft.filter((currentName, _) => currentName != candName)
        (candName, modelName)
    }).toList

    (mappings ++ remainingMappings, stmts)
}

def mapTypesToCounts(params: ListMap[String, Type]): Map[Type, Int] = 
    params.foldLeft(Map()) {
        case (accMap, (_, paramType)) => {
            val newEntry = accMap.get(paramType) match {
                case Some(count) => (paramType, count + 1)
                case None => (paramType, 1)
            }
            accMap + newEntry
        }
    }