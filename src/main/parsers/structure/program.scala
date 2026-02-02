package parsers.structure

import parsley.templates.{PureParserBridge2, PureParserBridge3, PureParserBridge5, PureParserBridge6}

sealed trait TopLevel

case class Parameter(name: String, paramType: Type)
object Parameter extends PureParserBridge2[String, Type, Parameter]
case class DeclaredType(name: String, typeParams: Option[List[Parameter]])
object DeclaredType extends PureParserBridge2[String, Option[List[Parameter]], DeclaredType]
case class Datatype(name: String, generic: Option[List[(String, Option[GOption])]], types: List[DeclaredType]) extends TopLevel
object Datatype extends PureParserBridge3[String, Option[List[(String, Option[GOption])]], List[DeclaredType], Datatype]
case class Function(name: String, generic: Option[List[(String, Option[GOption])]], params: List[Parameter], returnType: Type, specs: List[Spec], body: List[Expr]) extends TopLevel
object Function extends PureParserBridge6[String, Option[List[(String, Option[GOption])]], List[Parameter], Type, List[Spec], List[Expr], Function]
case class GhostFunction(name: String, generic: Option[List[(String, Option[GOption])]], params: List[Parameter], returnType: Type, specs: List[Spec], body: List[Expr]) extends TopLevel
object GhostFunction extends PureParserBridge6[String, Option[List[(String, Option[GOption])]], List[Parameter], Type, List[Spec], List[Expr], GhostFunction]
case class Lemma(name: String, generic: Option[List[(String, Option[GOption])]], params: List[Parameter], specs: List[Spec], body: Option[BlockStmt]) extends TopLevel
object Lemma extends PureParserBridge5[String, Option[List[(String, Option[GOption])]], List[Parameter], List[Spec], Option[BlockStmt], Lemma]

sealed trait GOption
case object Equals extends GOption
case object NotNew extends GOption