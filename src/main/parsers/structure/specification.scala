package parsers.structure

import parsley.templates.PureParserBridge1

sealed trait Spec

case class Requires(cond: BasicExpr) extends Spec
object Requires extends PureParserBridge1[BasicExpr, Requires]
case class Ensures(cond: BasicExpr) extends Spec
object Ensures extends PureParserBridge1[BasicExpr, Ensures]
case class Decreases(exprs: List[BasicExpr]) extends Spec
object Decreases extends PureParserBridge1[List[BasicExpr], Decreases]
