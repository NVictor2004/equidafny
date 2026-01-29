package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2}

sealed trait Type
case object TypeInt extends Type
case object TypeBool extends Type
case object TypeString extends Type
case object TypeChar extends Type
case object TypeNat extends Type
case class SeqType(elementType: Type) extends Type
object SeqType extends PureParserBridge1[Type, SeqType]
case class SetType(elementType: Type) extends Type
object SetType extends PureParserBridge1[Type, SetType]
case class NamedType(name: String, generics: Option[List[Type]]) extends Type
object NamedType extends PureParserBridge2[String, Option[List[Type]], NamedType]
case class TupleType(elements: List[Type]) extends Type
object TupleType extends PureParserBridge1[List[Type], TupleType]
case class ArrowType(from: Type, to: Type) extends Type
object ArrowType extends PureParserBridge2[Type, Type, ArrowType]