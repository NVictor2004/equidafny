package equivalence.types

import translation.structure.*

def getListOfTypes(t: DomainType): List[Type] = t match {
    case TupleType(elements) => elements
    case t => List(t)
}

def compatibleTypes(modelType: Type, candType: Type, typeFunctions: List[(Type, Function)]): Boolean = {
  def compatibleDomainTypesHelper(modelType: DomainType, candType: DomainType): Boolean = (modelType, candType) match {
    case (TypeInt, TypeInt) => true
    case (TypeBool, TypeBool) => true
    case (TypeString, TypeString) => true
    case (TypeChar, TypeChar) => true
    case (TypeNat, TypeNat) => true
    case (SeqType(modelType), SeqType(candType)) => compatibleTypesHelper(modelType, candType)
    case (CreatedType(modelName, modelGenerics), CreatedType(candName, candGenerics)) 
      if modelName == candName && modelGenerics.length == candGenerics.length => 
        modelGenerics.zip(candGenerics).forall((model, cand) => compatibleTypesHelper(model, cand))
    case (_: GenericType, _: GenericType) => true
    case (TupleType(modelElements), TupleType(candElements)) if modelElements.length == candElements.length => 
      modelElements.zip(candElements).forall((model, cand) => compatibleTypesHelper(model, cand))
    case _ => false
  }
  def compatibleTypesHelper(modelType: Type, candType: Type): Boolean = (modelType, candType) match {
    case (modelType: DomainType, candType: DomainType) => compatibleDomainTypesHelper(modelType, candType)
    case (ArrowType(modelFrom, modelTo), ArrowType(candFrom, candTo)) =>
      compatibleDomainTypesHelper(modelFrom, candFrom) && compatibleTypesHelper(modelTo, candTo)
    case _ => false 
  }

  val compatibleTypeFunction = typeFunctions.find((t, func) => compatibleTypesHelper(modelType, t) && compatibleTypesHelper(func.returnType, candType))
  compatibleTypeFunction match {
    case None => compatibleTypesHelper(modelType, candType)
    case _ => true
  } 
}

