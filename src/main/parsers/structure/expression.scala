package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2, PureParserBridge3}

// Creating the Expression data structure
sealed trait Expr

// Literals
case class Ident(name: String) extends Expr
object Ident extends PureParserBridge1[String, Ident]
case class BoolLiteral(value: Boolean) extends Expr
object BoolLiteral extends PureParserBridge1[Boolean, BoolLiteral]
case class CharLiteral(value: Int) extends Expr
object CharLiteral extends PureParserBridge1[Int, CharLiteral]
case class IntLiteral(value: BigInt) extends Expr
object IntLiteral extends PureParserBridge1[BigInt, IntLiteral]
case class StringLiteral(value: String) extends Expr
object StringLiteral extends PureParserBridge1[String, StringLiteral]
case class RealLiteral(value: BigDecimal) extends Expr
object RealLiteral extends PureParserBridge1[BigDecimal, RealLiteral]
case object Null extends Expr

// Operator Expressions
case class Iff(left: Expr, right: Expr) extends Expr
object Iff extends PureParserBridge2[Expr, Expr, Iff]
case class LeftImplies(left: Expr, right: Expr) extends Expr
object LeftImplies extends PureParserBridge2[Expr, Expr, LeftImplies]
case class RightImplies(left: Expr, right: Expr) extends Expr
object RightImplies extends PureParserBridge2[Expr, Expr, RightImplies]
case class BoolAnd(left: Expr, right: Expr) extends Expr
object BoolAnd extends PureParserBridge2[Expr, Expr, BoolAnd]
case class BoolOr(left: Expr, right: Expr) extends Expr
object BoolOr extends PureParserBridge2[Expr, Expr, BoolOr]
case class Eq(left: Expr, right: Expr) extends Expr
object Eq extends PureParserBridge2[Expr, Expr, Eq]
case class Neq(left: Expr, right: Expr) extends Expr
object Neq extends PureParserBridge2[Expr, Expr, Neq]
case class LT(left: Expr, right: Expr) extends Expr
object LT extends PureParserBridge2[Expr, Expr, LT]
case class LTE(left: Expr, right: Expr) extends Expr
object LTE extends PureParserBridge2[Expr, Expr, LTE]
case class GT(left: Expr, right: Expr) extends Expr
object GT extends PureParserBridge2[Expr, Expr, GT]
case class GTE(left: Expr, right: Expr) extends Expr
object GTE extends PureParserBridge2[Expr, Expr, GTE]
case class In(left: Expr, right: Expr) extends Expr
object In extends PureParserBridge2[Expr, Expr, In]
case class NotIn(left: Expr, right: Expr) extends Expr
object NotIn extends PureParserBridge2[Expr, Expr, NotIn]
case class Disjoint(left: Expr, right: Expr) extends Expr
object Disjoint extends PureParserBridge2[Expr, Expr, Disjoint]
case class LeftShift(left: Expr, right: Expr) extends Expr
object LeftShift extends PureParserBridge2[Expr, Expr, LeftShift]
case class RightShift(left: Expr, right: Expr) extends Expr
object RightShift extends PureParserBridge2[Expr, Expr, RightShift]
case class Add(left: Expr, right: Expr) extends Expr
object Add extends PureParserBridge2[Expr, Expr, Add]
case class Sub(left: Expr, right: Expr) extends Expr
object Sub extends PureParserBridge2[Expr, Expr, Sub]
case class Mul(left: Expr, right: Expr) extends Expr
object Mul extends PureParserBridge2[Expr, Expr, Mul]
case class Div(left: Expr, right: Expr) extends Expr
object Div extends PureParserBridge2[Expr, Expr, Div]
case class Mod(left: Expr, right: Expr) extends Expr
object Mod extends PureParserBridge2[Expr, Expr, Mod]
case class BitOr(left: Expr, right: Expr) extends Expr
object BitOr extends PureParserBridge2[Expr, Expr, BitOr]
case class BitAnd(left: Expr, right: Expr) extends Expr
object BitAnd extends PureParserBridge2[Expr, Expr, BitAnd]
case class BitXor(left: Expr, right: Expr) extends Expr
object BitXor extends PureParserBridge2[Expr, Expr, BitXor]
case class Neg(expr: Expr) extends Expr
object Neg extends PureParserBridge1[Expr, Neg]
case class Not(expr: Expr) extends Expr
object Not extends PureParserBridge1[Expr, Not]

// Statement-Like Expressions
case class Cond(cond: Expr, thenBranch: Expr, elseBranch: Expr) extends Expr
object Cond extends PureParserBridge3[Expr, Expr, Expr, Cond]
