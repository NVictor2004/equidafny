package translation.structure

sealed trait Index
case class ExprIndex(value: Expr) extends Index
case class StartSubIndex(value: Expr) extends Index
case class UpdateIndex(left: Expr, right: Expr) extends Index