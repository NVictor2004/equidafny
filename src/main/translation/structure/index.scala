package translation.structure

sealed trait Index
case class ExprIndex(value: BasicExpr) extends Index
case class StartSubIndex(value: BasicExpr) extends Index
case class UpdateIndex(left: BasicExpr, right: BasicExpr) extends Index
