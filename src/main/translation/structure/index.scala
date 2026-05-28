package translation.structure

// The Index data structure is used for indexing into sequences
sealed trait Index
case class ExprIndex(value: BasicExpr) extends Index
case class StartSubIndex(value: BasicExpr) extends Index
case class UpdateIndex(left: BasicExpr, right: BasicExpr) extends Index
