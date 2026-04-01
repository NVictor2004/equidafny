package equivalence.expression

import translation.structure.*

import equivalence.program.functionEquivalence

private def lookup[A, B](data: List[(A, B)], key: A): B =
    data.find((a, _) => a == key).get._2

def mergeBasicExpr(modelExpr: BasicExpr, modelFunc: Function, candidateExpr: BasicExpr, candidateFunc: Function)(using program: Program): (List[Lemma], List[(String, String)], List[Stmt]) = 
    (modelExpr, candidateExpr) match {
        case (TrueFunctionCall(calledInModel, calledInModelArgs), TrueFunctionCall(calledInCandidate, calledInCandidateArgs))
            if calledInModel != modelFunc.name && calledInCandidate != candidateFunc.name => {
            val funcCalledInModel = program.helperFunctions(calledInModel)
            val funcCalledInCandidate = program.helperFunctions(calledInCandidate)
            val (lemma, helperLemmas, mapping) = functionEquivalence(funcCalledInModel, funcCalledInCandidate)

            val basicExprMap = mapping.map {
                case (modelName, candName) => lookup(calledInModelArgs(0), modelName) -> lookup(calledInCandidateArgs(0), candName)
            }

            val finalMapping = basicExprMap.collect {
                case (Ident(name, Nil), Ident(name2, Nil)) => name -> name2
            }

            val finalStmt = CallStmt(lemma.name, calledInModelArgs.map(_.map((_, expr) => expr).toList))

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
            (Nil, List(modelName -> candName), Nil)
        }
        case _ => (Nil, Nil, Nil)
    }

def mergeExprBlock(modelExprBlock: ExprBlock, modelFunc: Function, candidateExprBlock: ExprBlock, candidateFunc: Function)(using program: Program): (List[Lemma], List[(String, String)], List[Stmt]) = {
    val ExprBlock(modelExtended, modelBasic) = modelExprBlock
    val ExprBlock(_, candBasic) = candidateExprBlock

    val modelVariables = modelExtended.collect {
        case Let(left, right) => LetStmt(left.map(_._1), right)
    }

    val (lemmas, mappings, stmts) = mergeBasicExpr(modelBasic, modelFunc, candBasic, candidateFunc)

    (lemmas, mappings, modelVariables ++ stmts)
}

def mergeFunction(modelFunc: Function, candidateFunc: Function)(using program: Program): (List[Lemma], List[(String, String)], List[Stmt]) = {
    val (lemmas, mappings, stmts) = mergeExprBlock(modelFunc.body, modelFunc, candidateFunc.body, candidateFunc)

    val modelParamsCovered = mappings.map(_._1)
    val candParamsCovered = mappings.map(_._2)

    val modelParamsLeft = modelFunc.params.filterNot(param => modelParamsCovered.contains(param.name))
    var candParamsLeft = candidateFunc.params.filterNot(param => candParamsCovered.contains(param.name))

    val typeMappings = modelParamsLeft.map(modelParameter => {
        val candParam = candParamsLeft.find(param => param.paramType == modelParameter.paramType).get
        candParamsLeft = candParamsLeft.filter(_ != candParam)
        (modelParameter.name, candParam.name)
    }).toList

    (lemmas, mappings ++ typeMappings, stmts)
}