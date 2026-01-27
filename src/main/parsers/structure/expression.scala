package parsers.structure

// Creating the Expression data structure
sealed trait Expr

// Operator Expressions
case class Iff(left: Expr, right: Expr) extends Expr
case class LeftImplies(left: Expr, right: Expr) extends Expr
case class RightImplies(left: Expr, right: Expr) extends Expr
case class BoolAnd(left: Expr, right: Expr) extends Expr
case class BoolOr(left: Expr, right: Expr) extends Expr
case class Eq(left: Expr, right: Expr) extends Expr
case class Neq(left: Expr, right: Expr) extends Expr
case class LT(left: Expr, right: Expr) extends Expr
case class LTE(left: Expr, right: Expr) extends Expr
case class GT(left: Expr, right: Expr) extends Expr
case class GTE(left: Expr, right: Expr) extends Expr
case class In(left: Expr, right: Expr) extends Expr
case class NotIn(left: Expr, right: Expr) extends Expr
case class Disjoint(left: Expr, right: Expr) extends Expr
case class LeftShift(left: Expr, right: Expr) extends Expr
case class RightShift(left: Expr, right: Expr) extends Expr
case class Add(left: Expr, right: Expr) extends Expr
case class Sub(left: Expr, right: Expr) extends Expr
case class Mul(left: Expr, right: Expr) extends Expr
case class Div(left: Expr, right: Expr) extends Expr
case class Mod(left: Expr, right: Expr) extends Expr
case class BitOr(left: Expr, right: Expr) extends Expr
case class BitAnd(left: Expr, right: Expr) extends Expr
case class BitXor(left: Expr, right: Expr) extends Expr
case class Neg(expr: Expr) extends Expr
case class Not(expr: Expr) extends Expr