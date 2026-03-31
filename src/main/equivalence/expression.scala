package equivalence.expression

import translation.structure.*

import equivalence.program.functionEquivalence

def mergeFunction(modelFunc: Function, candidateFunc: Function)(using program: Program): (List[Lemma], List[(Int, Int)], List[Stmt]) = {
    // Ignore extended expressions for now
    val ExprBlock(_, modelBasic) = modelFunc.body
    val ExprBlock(_, candidateBasic) = candidateFunc.body

    (modelBasic, candidateBasic) match {
        case (FunctionCall(calledInModel, calledInModelArgs), FunctionCall(calledInCandidate, calledInCandidateArgs)) => {
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

            (lemma :: helperLemmas, finalMapping, Nil)
        }
        case _ => (Nil, List(), Nil)
    }
        
    
}