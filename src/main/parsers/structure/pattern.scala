package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2}

// The Pattern data structure is used for pattern matching in match expressions
sealed trait Pattern
object UnNamed extends Pattern
case class Constant(value: LiteralExpr) extends Pattern
object Constant extends PureParserBridge1[LiteralExpr, Constant]
case class Basic(name: String, values: Option[List[Pattern]]) extends Pattern
object Basic extends PureParserBridge2[String, Option[List[Pattern]], Basic]
case class PatternTuple(elements: List[Pattern]) extends Pattern
object PatternTuple extends PureParserBridge1[List[Pattern], PatternTuple]
