package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2}

sealed trait Type
sealed trait DomainType extends Type

case object TypeInt extends DomainType
case object TypeBool extends DomainType
case object TypeString extends DomainType
case object TypeChar extends DomainType
case object TypeNat extends DomainType
case class SeqType(elementType: Type) extends DomainType
object SeqType extends PureParserBridge1[Type, SeqType]
case class SetType(elementType: Type) extends DomainType
object SetType extends PureParserBridge1[Type, SetType]
case class NamedType(name: String, generics: Option[List[Type]]) extends DomainType
object NamedType
    extends PureParserBridge2[String, Option[List[Type]], NamedType]
case class TupleType(elements: List[Type]) extends DomainType
object TupleType extends PureParserBridge1[List[Type], TupleType]
case class ArrowType(from: DomainType, to: Type) extends Type
object ArrowType extends PureParserBridge2[DomainType, Type, ArrowType]
