package translation.structure

sealed trait Spec

case class Requires(cond: BasicExpr) extends Spec
case class Ensures(cond: BasicExpr) extends Spec
case class Decreases(exprs: List[BasicExpr]) extends Spec
