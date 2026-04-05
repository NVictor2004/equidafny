package translation.structure

sealed trait BasicExpr
sealed trait LiteralExpr extends BasicExpr
sealed trait ExtendedExpr

// Main expression block data structure
case class ExprBlock(extendedExprs: List[ExtendedExpr], basicExpr: BasicExpr)

// Literals
case class BoolLiteral(value: Boolean) extends LiteralExpr
case class CharLiteral(value: Int) extends LiteralExpr
case class IntLiteral(value: BigInt) extends LiteralExpr
case class StringLiteral(value: String) extends LiteralExpr
case class RealLiteral(value: BigDecimal) extends LiteralExpr
case object Null extends LiteralExpr

enum BinaryOperator {
  case Iff, LeftImplies, RightImplies, BoolAnd, BoolOr, Eq, Neq, LT, LTE, GT,
    GTE,
    In, NotIn, Disjoint, LeftShift, RightShift, Add, Sub, Mul, Div, Mod,
    BitOr, BitAnd, BitXor
}

enum UnaryOperator {
  case Neg, Not
}

enum Quantifier {
  case Forall, Exists
}

// Operator Expressions
case class Binary(operator: BinaryOperator, left: BasicExpr, right: BasicExpr)
    extends BasicExpr
case class Unary(operator: UnaryOperator, expr: BasicExpr) extends BasicExpr
case class Quantified(
    quantifier: Quantifier,
    variable: String,
    varType: Option[Type],
    body: BasicExpr
) extends BasicExpr

// Basic Higher-level Expressions
case class Ident(name: String, suffixes: List[String]) extends BasicExpr
case class Cardinality(expr: BasicExpr) extends BasicExpr
case class Tuple(elements: List[BasicExpr]) extends BasicExpr
case class Cond(cond: BasicExpr, thenBranch: ExprBlock, elseBranch: ExprBlock)
    extends BasicExpr
case class TrueFunctionCall(name: String, args: List[List[(String, BasicExpr)]])
    extends BasicExpr
case class OtherFunctionCall(name: String, args: List[List[BasicExpr]])
    extends BasicExpr
case class LambdaCall(lambda: Lambda, args: List[BasicExpr]) extends BasicExpr
case class Match(expr: BasicExpr, cases: List[(Pattern, ExprBlock)])
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
