package translation.structure

sealed trait Type
case object TypeInt extends Type
case object TypeBool extends Type
case object TypeString extends Type
case object TypeChar extends Type
case object TypeNat extends Type
case class SeqType(elementType: Type) extends Type
case class SetType(elementType: Type) extends Type
case class CreatedType(name: String, generics: List[Type]) extends Type
case class GenericType(name: String) extends Type
case class TupleType(elements: List[Type]) extends Type
case class ArrowType(from: Type, to: Type) extends Type
