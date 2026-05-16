package equivalence.pattern

import translation.structure.* 

def mergePattern(modelPattern: Pattern, candPattern: Pattern): Boolean = (modelPattern, candPattern) match {
    case (_, UnNamed) => true
    case (UnNamed, _) => true
    case (PatternTuple(modelElements), PatternTuple(candElements)) if modelElements.length == candElements.length => 
        modelElements.zip(candElements).forall((model, cand) => mergePattern(model, cand))
    case (Basic(modelName, modelValues), Basic(candName, candValues)) if modelName == candName => 
        modelValues.zip(candValues).forall((model, cand) => mergePattern(model, cand))
    case (PatternDatatypeConstant(modelValue), PatternDatatypeConstant(candValue)) => modelValue == candValue
    case (PatternIdent(_), _) => true
    case (_, PatternIdent(_)) => true
    case (Constant(modelValue), Constant(candValue)) => modelValue == candValue
    case _ => false
}
