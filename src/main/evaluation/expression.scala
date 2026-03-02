package evaluation.expression

import translation.structure.*

final val NullLiteralCost = 1
final val RealLiteralCost = 1
final val StringLiteralCost = 1
final val IntLiteralCost = 1
final val CharLiteralCost = 1
final val BoolLiteralCost = 1

final val BinaryOperatorCost = 1
final val UnaryOperatorCost = 1
final val QuantifiedCost = 1
final val IdentCost = 1
final val IdentSuffixCost = 1
final val CardinalityCost = 1
final val TupleCost = 1
final val BracketsCost = 1

final val MethodCallCost = 1

def evaluateBasicExpr(expr: BasicExpr): Int = expr match {
  case lit: LiteralExpr       => evaluateLiteralExpr(lit)
  case Binary(_, left, right) =>
    BinaryOperatorCost + evaluateBasicExpr(left) + evaluateBasicExpr(right)
  case Unary(_, expr)            => UnaryOperatorCost + evaluateBasicExpr(expr)
  case Quantified(_, _, _, body) => QuantifiedCost + evaluateBasicExpr(body)
  case Ident(_, suffixes) => IdentCost + suffixes.length * IdentSuffixCost
  case Cardinality(expr)  => CardinalityCost + evaluateBasicExpr(expr)
  case Tuple(elements)    => TupleCost + elements.map(evaluateBasicExpr).sum
  case Brackets(expr)     => BracketsCost + evaluateBasicExpr(expr)
  case Cond(cond, thenBranch, elseBranch) => ???
  case FunctionCall(name, args)           => ???
  case LambdaCall(lambda, args)           => ???
  case Match(expr, cases)                 => ???
  case Set(elements)                      => ???
  case Seq(elements)                      => ???
  case Lambda(lvalues, body)              => ???
  case SeqIndex(name, indexes)            => ???
}

def evaluateLiteralExpr(expr: LiteralExpr): Int = expr match {
  case _: BoolLiteral   => BoolLiteralCost
  case _: CharLiteral   => CharLiteralCost
  case _: IntLiteral    => IntLiteralCost
  case _: StringLiteral => StringLiteralCost
  case _: RealLiteral   => RealLiteralCost
  case Null             => NullLiteralCost
}

def evaluateExtendedExpr(expr: ExtendedExpr): Int = ???
