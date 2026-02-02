package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2}

// The Index data structure is used for indexing into sequences
sealed trait Index
case class ExprIndex(value: Expr) extends Index
object ExprIndex extends PureParserBridge1[Expr, ExprIndex]
case class StartSubIndex(value: Expr) extends Index
object StartSubIndex extends PureParserBridge1[Expr, StartSubIndex]
case class UpdateIndex(left: Expr, right: Expr) extends Index
object UpdateIndex extends PureParserBridge2[Expr, Expr, UpdateIndex]