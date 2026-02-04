package translation.structure

sealed trait Expr
sealed trait BasicExpr extends Expr
sealed trait LiteralExpr extends BasicExpr
sealed trait ExtendedExpr extends Expr

// Main expression block data structure
case class ExprBlock(extendedExprs: List[ExtendedExpr], basicExpr: BasicExpr)

// Literals
case class Ident(name: String, suffixes: List[String]) extends LiteralExpr
case class BoolLiteral(value: Boolean) extends LiteralExpr
case class CharLiteral(value: Int) extends LiteralExpr
case class IntLiteral(value: BigInt) extends LiteralExpr
case class StringLiteral(value: String) extends LiteralExpr
case class RealLiteral(value: BigDecimal) extends LiteralExpr
case object Null extends LiteralExpr
case class Cardinality(expr: BasicExpr) extends LiteralExpr
case class Tuple(elements: List[BasicExpr]) extends LiteralExpr
case class Brackets(expr: BasicExpr) extends LiteralExpr

// Operator Expressions
case class Iff(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class LeftImplies(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class RightImplies(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class BoolAnd(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class BoolOr(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Eq(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Neq(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class LT(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class LTE(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class GT(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class GTE(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class In(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class NotIn(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Disjoint(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class LeftShift(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class RightShift(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Add(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Sub(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Mul(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Div(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Mod(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class BitOr(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class BitAnd(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class BitXor(left: BasicExpr, right: BasicExpr) extends BasicExpr
case class Neg(expr: BasicExpr) extends BasicExpr
case class Not(expr: BasicExpr) extends BasicExpr
case class Forall(variable: String, varType: Option[Type], body: BasicExpr)
    extends BasicExpr
case class Exists(variable: String, varType: Option[Type], body: BasicExpr)
    extends BasicExpr

// Basic Higher-level Expressions
case class Cond(cond: Expr, thenBranch: ExprBlock, elseBranch: ExprBlock)
    extends BasicExpr
case class FunctionCall(name: String, args: List[List[BasicExpr]])
    extends BasicExpr
case class LambdaCall(lambda: Lambda, args: List[BasicExpr]) extends BasicExpr
case class Match(expr: Expr, cases: List[(Pattern, ExprBlock)])
    extends BasicExpr
case class Set(elements: List[BasicExpr]) extends BasicExpr
case class Seq(elements: List[BasicExpr]) extends BasicExpr
case class Lambda(lvalues: List[(String, Option[Type])], body: ExprBlock)
    extends BasicExpr
case class SeqIndex(name: String, indexes: List[Index]) extends BasicExpr

// Extended Higher-level Expressions
case class MethodCall(name: String, args: List[BasicExpr]) extends ExtendedExpr
case class Let(left: List[(String, Option[Type])], right: BasicExpr)
    extends ExtendedExpr
case class LetOrFail(left: String, leftType: Option[Type], right: BasicExpr)
    extends ExtendedExpr
case class Assert(expr: BasicExpr) extends ExtendedExpr
