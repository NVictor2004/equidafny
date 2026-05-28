package translation.structure

sealed trait Type
sealed trait DomainType extends Type

// Data structures representing each possible type of type
case object TypeInt extends DomainType
case object TypeBool extends DomainType
case object TypeString extends DomainType
case object TypeChar extends DomainType
case object TypeNat extends DomainType
case object TypeReal extends DomainType
case class SeqType(elementType: Type) extends DomainType
case class SetType(elementType: Type) extends DomainType
case class CreatedType(name: String, generics: List[Type]) extends DomainType
case class GenericType(name: String) extends DomainType
case class TupleType(elements: List[Type]) extends DomainType
case class ArrowType(from: DomainType, to: Type) extends Type
