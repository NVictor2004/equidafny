package parsers.structure

import parsley.templates.PureParserBridge1

sealed trait Spec

case class Requires(cond: Expr) extends Spec
object Requires extends PureParserBridge1[Expr, Requires]
case class Ensures(cond: Expr) extends Spec
object Ensures extends PureParserBridge1[Expr, Ensures]
case class Decreases(exprs: List[Expr]) extends Spec
object Decreases extends PureParserBridge1[List[Expr], Decreases]