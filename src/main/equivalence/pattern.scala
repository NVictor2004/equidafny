package equivalence.pattern

import translation.structure.* 

def mergePattern(modelPattern: Pattern, candPattern: Pattern): Boolean = (modelPattern, candPattern) match {
    case (_, UnNamed) => true
    case (UnNamed, _) => true
    case (PatternTuple(modelElements), PatternTuple(candElements)) if modelElements.length == candElements.length => 
        modelElements.zip(candElements).forall((model, cand) => mergePattern(model, cand))
    case (model, cand) => model == cand
}
