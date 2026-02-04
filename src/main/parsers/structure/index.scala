package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2}

// The Index data structure is used for indexing into sequences
sealed trait Index
case class ExprIndex(value: BasicExpr) extends Index
object ExprIndex extends PureParserBridge1[BasicExpr, ExprIndex]
case class StartSubIndex(value: BasicExpr) extends Index
object StartSubIndex extends PureParserBridge1[BasicExpr, StartSubIndex]
case class UpdateIndex(left: BasicExpr, right: BasicExpr) extends Index
object UpdateIndex extends PureParserBridge2[BasicExpr, BasicExpr, UpdateIndex]
