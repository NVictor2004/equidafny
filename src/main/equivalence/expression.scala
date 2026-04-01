package equivalence.expression

import translation.structure.*

import equivalence.program.functionEquivalence
import equivalence.{expression => calledInModelArgs}

def mergeBasicExpr(modelExpr: BasicExpr, modelFunc: Function, candidateExpr: BasicExpr, candidateFunc: Function)(using program: Program): (List[Lemma], List[(Int, Int)], List[Stmt]) = 
    (modelExpr, candidateExpr) match {
        case (FunctionCall(calledInModel, calledInModelArgs), FunctionCall(calledInCandidate, calledInCandidateArgs))
            if calledInModel != modelFunc.name && calledInCandidate != candidateFunc.name => {
            val funcCalledInModel = program.helperFunctions.find(_.name == calledInModel).get
            val funcCalledInCandidate = program.helperFunctions.find(_.name == calledInCandidate).get
            val (lemma, helperLemmas, mapping) = functionEquivalence(funcCalledInModel, funcCalledInCandidate)

            val basicExprMap = mapping.map {
                case (modelIndex, candidateIndex) => calledInModelArgs(0)(modelIndex) -> calledInCandidateArgs(0)(candidateIndex)
            }

            val identMap = basicExprMap.collect {
                case (Ident(name, Nil), Ident(name2, Nil)) => name -> name2
            }

            val finalMapping = identMap.map {
                case (modelIdent, candIdent) => {
                    val modelParamIndex = modelFunc.params.indexWhere(_.name == modelIdent)
                    val candParamIndex = candidateFunc.params.indexWhere(_.name == candIdent)

                    (modelParamIndex, candParamIndex)
                }
            }

            val finalStmt = CallStmt(lemma.name, calledInModelArgs)

            (lemma :: helperLemmas, finalMapping, List(finalStmt))
        }
        case (Cond(modelCond, modelThen, modelElse), Cond(candidateCond, candidateThen, candidateElse)) => {
            val (condHelpers, condMappings, condStmts) = mergeBasicExpr(modelCond, modelFunc, candidateCond, candidateFunc)
            val (thenHelpers, thenMappings, thenStmts) = mergeExprBlock(modelThen, modelFunc, candidateThen, candidateFunc)
            val (elseHelpers, elseMappings, elseStmts) = mergeExprBlock(modelElse, modelFunc, candidateElse, candidateFunc)

            val finalStmts = (thenStmts, elseStmts) match {
                case (Nil, Nil) => condStmts
                case _ => condStmts ++ List(CondStmt(modelCond, BlockStmt(thenStmts), Some(BlockStmt(elseStmts))))
            }

            // TODO: Mappings concatenation
            (condHelpers ++ thenHelpers ++ elseHelpers, condMappings ++ thenMappings ++ elseMappings, finalStmts)
        }
        case (Tuple(modelElements), Tuple(candElements)) if modelElements.length == candElements.length => {
            val data = modelElements.zip(candElements).map((modelElem, candElem) => mergeBasicExpr(modelElem, modelFunc, candElem, candidateFunc))
            data.foldLeft((List(), List(), List())) {
                case ((accHelpers, accMappings, accStmts), (helpers, mappings, stmts)) => (
                    accHelpers ++ helpers, accMappings ++ mappings, accStmts ++ stmts
                )
            }
        }
        case (Ident(modelName, Nil), Ident(candName, Nil)) => {
            val modelParamIndex = modelFunc.params.indexWhere(_.name == modelName)
            val candParamIndex = candidateFunc.params.indexWhere(_.name == candName)

            (Nil, List(modelParamIndex -> candParamIndex), Nil)
        }
        case _ => (Nil, List(), Nil)
    }

def mergeExprBlock(modelExprBlock: ExprBlock, modelFunc: Function, candidateExprBlock: ExprBlock, candidateFunc: Function)(using program: Program): (List[Lemma], List[(Int, Int)], List[Stmt]) = {
    // Ignore extended expressions for now
    val ExprBlock(_, modelBasic) = modelExprBlock
    val ExprBlock(_, candidateBasic) = candidateExprBlock

    mergeBasicExpr(modelBasic, modelFunc, candidateBasic, candidateFunc)
}

def mergeFunction(modelFunc: Function, candidateFunc: Function)(using program: Program): (List[Lemma], List[(Int, Int)], List[Stmt]) = {
    val (lemmas, mappings, stmts) = mergeExprBlock(modelFunc.body, modelFunc, candidateFunc.body, candidateFunc)

    val modelIndicesCovered = mappings.map(_._1)
    val candIndicesCovered = mappings.map(_._2)

    val modelIndicesLeft = (0 to modelFunc.params.length - 1).filterNot(modelIndicesCovered.contains(_))
    var candIndicesLeft = (0 to candidateFunc.params.length - 1).filterNot(candIndicesCovered.contains(_))

    val typeMappings = modelIndicesLeft.map(modelIndex => {
        val modelParam = modelFunc.params(modelIndex)
        val candIndex = candIndicesLeft.find(i => candidateFunc.params(i).paramType == modelParam.paramType).get
        candIndicesLeft = candIndicesLeft.filter(_ != candIndex)
        (modelIndex, candIndex)
    }).toList

    (lemmas, mappings ++ typeMappings, stmts)
}