package evaluation.expression

import translation.structure.*

import evaluation.pattern.evaluatePattern
import evaluation.index.evaluateIndex
import evaluation.config.*

def evaluateBasicExpr(expr: BasicExpr): Double = expr match {
  case lit: LiteralExpr       => evaluateLiteralExpr(lit)
  case TupleExtraction(_, _)  => TupleExtractionCost
  case TypeCast(expr, _)      => TypeCastCost + evaluateBasicExpr(expr) + TypeCost
  case Binary(_, left, right) =>
    BinaryOperatorCost + evaluateBasicExpr(left) + evaluateBasicExpr(right)
  case Unary(_, expr)                     => UnaryOperatorCost + evaluateBasicExpr(expr)
  case Quantified(_, _, varType, body)    => QuantifiedCost + varType.fold(0.0)(_ => TypeCost) + evaluateBasicExpr(body)
  case Ident(_, suffixes)                 => IdentCost + suffixes.length * IdentSuffixCost
  case Cardinality(expr)                  => CardinalityCost + evaluateBasicExpr(expr)
  case Tuple(elements)                    => TupleCost + elements.map(evaluateBasicExpr).sum
  case Cond(cond, thenBranch, elseBranch) =>
    CondCost + evaluateBasicExpr(cond) + evaluateExprBlock(thenBranch) + evaluateExprBlock(elseBranch)
  case TrueFunctionCall(_, args)  => CallCost + args.flatMap(_.values.map(evaluateBasicExpr)).sum
  case OtherFunctionCall(_, args) => CallCost + args.flatMap(_.map(evaluateBasicExpr)).sum
  case LambdaCall(lambda, args)   => LambdaCallCost + evaluateBasicExpr(lambda) + args.map(evaluateBasicExpr).sum
  case Match(expr, cases)         =>
    MatchCost + evaluateBasicExpr(expr) + cases
      .map((pattern, block) => evaluatePattern(pattern) + evaluateExprBlock(block))
      .sum
  case Set(elements)         => SetConstructionCost + elements.map(evaluateBasicExpr).sum
  case Seq(elements)         => SeqConstructionCost + elements.map(evaluateBasicExpr).sum
  case Lambda(lvalues, body) =>
    LambdaCost + lvalues.map(_._2.fold(0.0)(_ => TypeCost)).sum + evaluateExprBlock(body)
  case SeqIndex(_, indexes) => SeqIndexCost + indexes.map(evaluateIndex).sum
}

def evaluateLiteralExpr(expr: LiteralExpr): Double = expr match {
  case _: BoolLiteral      => BoolLiteralCost
  case _: CharLiteral      => CharLiteralCost
  case _: IntLiteral       => IntLiteralCost
  case _: StringLiteral    => StringLiteralCost
  case _: RealLiteral      => RealLiteralCost
  case _: DatatypeConstant => IdentCost
  case Null                => NullLiteralCost
}

private def evaluateExtendedExpr(expr: ExtendedExpr): Double = expr match {
  case MethodCall(_, args)           => CallCost + args.map(evaluateBasicExpr).sum
  case Let(left, right)              => LetCost + left.map(_._2.fold(0.0)(_ => TypeCost)).sum + evaluateBasicExpr(right)
  case LetOrFail(_, leftType, right) => LetOrFailCost + leftType.fold(0.0)(_ => TypeCost) + evaluateBasicExpr(right)
  case Assert(expr)                  => AssertCost + evaluateBasicExpr(expr)
}

private def evaluateExprBlock(expr: ExprBlock): Double = {
  val ExprBlock(extendedExprs, basic) = expr
  extendedExprs.map(evaluateExtendedExpr).sum + evaluateBasicExpr(basic)
}
