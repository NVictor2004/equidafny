package equivalence.expression

import translation.structure.*

import equivalence.program.{mergeFunction, generateLemmaName}
import equivalence.pattern.*
import scala.collection.immutable.ListMap
import scala.collection.mutable.Map as MutableMap

private def numberOfArguments[A, B](data: List[ListMap[A, B]]): Int = data.map(_.size).sum

def mergeBasicExpr(currentLemmas: MutableMap[String, Option[Lemma]], currentMappings: MutableMap[String, String], modelExpr: BasicExpr, modelFunc: Function, candidateExpr: BasicExpr, candidateFunc: Function)(using program: Program): List[Stmt] = {
    val finalStmts = (modelExpr, candidateExpr) match {
        case (TrueFunctionCall(calledInModel, calledInModelArgs), TrueFunctionCall(calledInCandidate, calledInCandidateArgs))
        if calledInModel != calledInCandidate && numberOfArguments(calledInModelArgs) == numberOfArguments(calledInCandidateArgs) => {
            
            val mapping =
                if currentLemmas.get(calledInModel).isDefined then currentMappings
                else {
                    // This pair of functions has not been encountered yet, merge the functions themselves
                    val funcCalledInModel = program.helperFunctions(calledInModel)
                    val funcCalledInCandidate = program.helperFunctions(calledInCandidate)
                    val (lemma, mapping) = mergeFunction(currentLemmas, funcCalledInModel, funcCalledInCandidate)
                    currentLemmas += lemma
                    mapping
                }

            // Convert mapping between the parameters of the called functions to a mapping between the arguments in the function calls
            // Merge these arguments together
            val stmts = mapping.map {
                case (candName, modelName) => calledInCandidateArgs(0)(candName) -> calledInModelArgs(0)(modelName)
            }.flatMap((candExpr, modelExpr) => mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc)).toList

            // Call the generated helper equivalence lemma
            val finalStmt = CallStmt(generateLemmaName(calledInModel, calledInCandidate), List(calledInModelArgs.flatMap(_.map(_._2))))

            stmts :+ finalStmt
        }
        case (OtherFunctionCall(calledInModel, calledInModelArgs), OtherFunctionCall(calledInCand, calledInCandArgs)) if calledInModel == calledInCand => {
            val flattened = calledInModelArgs.zip(calledInCandArgs).flatMap((modelList, candList) => modelList.zip(candList))
            flattened.flatMap((modelExpr, candExpr) => mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc))
        }
        case (Cond(modelCond, modelThen, modelElse), Cond(candidateCond, candidateThen, candidateElse)) => {
            val condStmts = mergeBasicExpr(currentLemmas, currentMappings, modelCond, modelFunc, candidateCond, candidateFunc)
            val thenStmts = mergeExprBlock(currentLemmas, currentMappings, modelThen, modelFunc, candidateThen, candidateFunc)
            val elseStmts = mergeExprBlock(currentLemmas, currentMappings, modelElse, modelFunc, candidateElse, candidateFunc)

            (thenStmts, elseStmts) match {
                case (Nil, Nil) => condStmts
                case _ => condStmts ++ List(CondStmt(modelCond, BlockStmt(thenStmts), Some(BlockStmt(elseStmts))))
            }
        }
        case (Tuple(modelElements), Tuple(candElements)) if modelElements.length == candElements.length =>
            modelElements.zip(candElements).flatMap((modelElem, candElem) => mergeBasicExpr(currentLemmas, currentMappings, modelElem, modelFunc, candElem, candidateFunc))

        case (Binary(modelOp, 
                     modelLeft @ TrueFunctionCall(_, modelLeftArgs), modelRight @ TrueFunctionCall(_, modelRightArgs)),
              Binary(candOp,
                     candLeft @ TrueFunctionCall(_, candLeftArgs), candRight @ TrueFunctionCall(_, candRightArgs)))
              if modelOp == candOp &&
                 numberOfArguments(modelLeftArgs) == numberOfArguments(candRightArgs) && 
                 numberOfArguments(modelRightArgs) == numberOfArguments(candLeftArgs) &&
                 numberOfArguments(modelLeftArgs) != numberOfArguments(candLeftArgs) &&
                 numberOfArguments(modelRightArgs) != numberOfArguments(candRightArgs) => {
            val leftStmts = mergeBasicExpr(currentLemmas, currentMappings, modelLeft, modelFunc, candRight, candidateFunc)
            val rightStmts = mergeBasicExpr(currentLemmas, currentMappings, modelRight, modelFunc, candLeft, candidateFunc)
            leftStmts ++ rightStmts
        }
        case (Binary(modelOp, modelLeft, modelRight), Binary(candOp, candLeft, candRight)) if modelOp == candOp => {
            val leftStmts = mergeBasicExpr(currentLemmas, currentMappings, modelLeft, modelFunc, candLeft, candidateFunc)
            val rightStmts = mergeBasicExpr(currentLemmas, currentMappings, modelRight, modelFunc, candRight, candidateFunc)
            leftStmts ++ rightStmts
        }
        case (Unary(modelOp, modelExpr), Unary(candOp, candExpr)) if modelOp == candOp => 
            mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc)

        case (Ident(modelName, Nil), Ident(candName, Nil)) => {
            currentMappings += (candName -> modelName)
            Nil
        }
        case (Match(modelExpr, modelCases), Match(candExpr, candCases)) => {
            val exprStmts = mergeBasicExpr(currentLemmas, currentMappings, modelExpr, modelFunc, candExpr, candidateFunc)

            val finalMatchStmts = modelCases.map((modelPattern, modelBlock) => {
                val matchingCandBlocks = candCases.collect {
                    case (candPattern, candBlock) if mergePattern(modelPattern, candPattern) => candBlock
                }
                val stmts = matchingCandBlocks.flatMap(candBlock => mergeExprBlock(currentLemmas, currentMappings, modelBlock, modelFunc, candBlock, candidateFunc))
                (modelPattern, stmts)
            })

            val allEmpty = finalMatchStmts.forall(_._2.isEmpty)
            if allEmpty then exprStmts else exprStmts :+ MatchStmt(modelExpr, finalMatchStmts)
        }
        case _ => Nil
    }

    val modelParamNames = modelFunc.params.map(_._1).toList
    currentMappings.filterInPlace((_, modelName) => modelParamNames.contains(modelName))
    finalStmts
}

def mergeExprBlock(currentLemmas: MutableMap[String, Option[Lemma]], currentMappings: MutableMap[String, String], modelExprBlock: ExprBlock, modelFunc: Function, candidateExprBlock: ExprBlock, candidateFunc: Function)(using program: Program): List[Stmt] = {
    val ExprBlock(modelExtended, modelBasic) = modelExprBlock
    val ExprBlock(_, candBasic) = candidateExprBlock

    val stmts = mergeBasicExpr(currentLemmas, currentMappings, modelBasic, modelFunc, candBasic, candidateFunc)

    val modelVariables = stmts match {
        case Nil => Nil
        case _ => modelExtended.collect {
            case Let(left, right) => LetStmt(left.map(_._1), right)
        }
    }

    modelVariables ++ stmts
}
