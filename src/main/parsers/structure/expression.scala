package parsers.structure

import parsley.templates.{
  PureParserBridge1,
  PureParserBridge2,
  PureParserBridge3
}

sealed trait Expr
sealed trait BasicExpr extends Expr
sealed trait LiteralExpr extends BasicExpr
sealed trait ExtendedExpr extends Expr

// Main expression block data structure
case class ExprBlock(extendedExprs: List[ExtendedExpr], basicExpr: BasicExpr)
object ExprBlock
    extends PureParserBridge2[List[ExtendedExpr], BasicExpr, ExprBlock]

// Literals
case class Ident(name: String, suffixes: List[String]) extends LiteralExpr
object Ident extends PureParserBridge2[String, List[String], Ident]
case class BoolLiteral(value: Boolean) extends LiteralExpr
object BoolLiteral extends PureParserBridge1[Boolean, BoolLiteral]
case class CharLiteral(value: Int) extends LiteralExpr
object CharLiteral extends PureParserBridge1[Int, CharLiteral]
case class IntLiteral(value: BigInt) extends LiteralExpr
object IntLiteral extends PureParserBridge1[BigInt, IntLiteral]
case class StringLiteral(value: String) extends LiteralExpr
object StringLiteral extends PureParserBridge1[String, StringLiteral]
case class RealLiteral(value: BigDecimal) extends LiteralExpr
object RealLiteral extends PureParserBridge1[BigDecimal, RealLiteral]
case object Null extends LiteralExpr
case class Cardinality(expr: BasicExpr) extends LiteralExpr
object Cardinality extends PureParserBridge1[BasicExpr, Cardinality]
case class Tuple(elements: List[BasicExpr]) extends LiteralExpr
object Tuple extends PureParserBridge1[List[BasicExpr], Tuple]
case class Brackets(expr: BasicExpr) extends LiteralExpr
object Brackets extends PureParserBridge1[BasicExpr, Brackets]

// Operator Expressions
case class Iff(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Iff extends PureParserBridge2[BasicExpr, BasicExpr, Iff]
case class LeftImplies(left: BasicExpr, right: BasicExpr) extends BasicExpr
object LeftImplies extends PureParserBridge2[BasicExpr, BasicExpr, LeftImplies]
case class RightImplies(left: BasicExpr, right: BasicExpr) extends BasicExpr
object RightImplies
    extends PureParserBridge2[BasicExpr, BasicExpr, RightImplies]
case class BoolAnd(left: BasicExpr, right: BasicExpr) extends BasicExpr
object BoolAnd extends PureParserBridge2[BasicExpr, BasicExpr, BoolAnd]
case class BoolOr(left: BasicExpr, right: BasicExpr) extends BasicExpr
object BoolOr extends PureParserBridge2[BasicExpr, BasicExpr, BoolOr]
case class Eq(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Eq extends PureParserBridge2[BasicExpr, BasicExpr, Eq]
case class Neq(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Neq extends PureParserBridge2[BasicExpr, BasicExpr, Neq]
case class LT(left: BasicExpr, right: BasicExpr) extends BasicExpr
object LT extends PureParserBridge2[BasicExpr, BasicExpr, LT]
case class LTE(left: BasicExpr, right: BasicExpr) extends BasicExpr
object LTE extends PureParserBridge2[BasicExpr, BasicExpr, LTE]
case class GT(left: BasicExpr, right: BasicExpr) extends BasicExpr
object GT extends PureParserBridge2[BasicExpr, BasicExpr, GT]
case class GTE(left: BasicExpr, right: BasicExpr) extends BasicExpr
object GTE extends PureParserBridge2[BasicExpr, BasicExpr, GTE]
case class In(left: BasicExpr, right: BasicExpr) extends BasicExpr
object In extends PureParserBridge2[BasicExpr, BasicExpr, In]
case class NotIn(left: BasicExpr, right: BasicExpr) extends BasicExpr
object NotIn extends PureParserBridge2[BasicExpr, BasicExpr, NotIn]
case class Disjoint(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Disjoint extends PureParserBridge2[BasicExpr, BasicExpr, Disjoint]
case class LeftShift(left: BasicExpr, right: BasicExpr) extends BasicExpr
object LeftShift extends PureParserBridge2[BasicExpr, BasicExpr, LeftShift]
case class RightShift(left: BasicExpr, right: BasicExpr) extends BasicExpr
object RightShift extends PureParserBridge2[BasicExpr, BasicExpr, RightShift]
case class Add(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Add extends PureParserBridge2[BasicExpr, BasicExpr, Add]
case class Sub(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Sub extends PureParserBridge2[BasicExpr, BasicExpr, Sub]
case class Mul(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Mul extends PureParserBridge2[BasicExpr, BasicExpr, Mul]
case class Div(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Div extends PureParserBridge2[BasicExpr, BasicExpr, Div]
case class Mod(left: BasicExpr, right: BasicExpr) extends BasicExpr
object Mod extends PureParserBridge2[BasicExpr, BasicExpr, Mod]
case class BitOr(left: BasicExpr, right: BasicExpr) extends BasicExpr
object BitOr extends PureParserBridge2[BasicExpr, BasicExpr, BitOr]
case class BitAnd(left: BasicExpr, right: BasicExpr) extends BasicExpr
object BitAnd extends PureParserBridge2[BasicExpr, BasicExpr, BitAnd]
case class BitXor(left: BasicExpr, right: BasicExpr) extends BasicExpr
object BitXor extends PureParserBridge2[BasicExpr, BasicExpr, BitXor]
case class Neg(expr: BasicExpr) extends BasicExpr
object Neg extends PureParserBridge1[BasicExpr, Neg]
case class Not(expr: BasicExpr) extends BasicExpr
object Not extends PureParserBridge1[BasicExpr, Not]
case class Forall(variable: String, varType: Option[Type], body: BasicExpr)
    extends BasicExpr
object Forall extends PureParserBridge3[String, Option[Type], BasicExpr, Forall]
case class Exists(variable: String, varType: Option[Type], body: BasicExpr)
    extends BasicExpr
object Exists extends PureParserBridge3[String, Option[Type], BasicExpr, Exists]

// Basic Higher-level Expressions
case class Cond(cond: Expr, thenBranch: ExprBlock, elseBranch: ExprBlock)
    extends BasicExpr
object Cond extends PureParserBridge3[Expr, ExprBlock, ExprBlock, Cond]
case class FunctionCall(name: String, args: List[List[BasicExpr]])
    extends BasicExpr
object FunctionCall
    extends PureParserBridge2[String, List[List[BasicExpr]], FunctionCall]
case class LambdaCall(lambda: Lambda, args: List[BasicExpr]) extends BasicExpr
object LambdaCall extends PureParserBridge2[Lambda, List[BasicExpr], LambdaCall]
case class Match(expr: Expr, cases: List[(Pattern, ExprBlock)])
    extends BasicExpr
object Match extends PureParserBridge2[Expr, List[(Pattern, ExprBlock)], Match]
case class Set(elements: List[BasicExpr]) extends BasicExpr
object Set extends PureParserBridge1[List[BasicExpr], Set]
case class Seq(elements: List[BasicExpr]) extends BasicExpr
object Seq extends PureParserBridge1[List[BasicExpr], Seq]
case class Lambda(lvalues: List[(String, Option[Type])], body: ExprBlock)
    extends BasicExpr
object Lambda
    extends PureParserBridge2[List[(String, Option[Type])], ExprBlock, Lambda]
case class SeqIndex(name: String, indexes: List[Index]) extends BasicExpr
object SeqIndex extends PureParserBridge2[String, List[Index], SeqIndex]

// Extended Higher-level Expressions
case class MethodCall(name: String, args: List[BasicExpr]) extends ExtendedExpr
object MethodCall extends PureParserBridge2[String, List[BasicExpr], MethodCall]
case class Let(left: List[(String, Option[Type])], right: BasicExpr)
    extends ExtendedExpr
object Let
    extends PureParserBridge2[List[(String, Option[Type])], BasicExpr, Let]
case class LetOrFail(left: String, leftType: Option[Type], right: BasicExpr)
    extends ExtendedExpr
object LetOrFail
    extends PureParserBridge3[String, Option[Type], BasicExpr, LetOrFail]
case class Assert(expr: BasicExpr) extends ExtendedExpr
object Assert extends PureParserBridge1[BasicExpr, Assert]
