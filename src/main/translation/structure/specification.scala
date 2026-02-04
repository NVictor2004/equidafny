package translation.structure

sealed trait Spec

case class Requires(cond: Expr) extends Spec
case class Ensures(cond: Expr) extends Spec
case class Decreases(exprs: List[Expr]) extends Spec
