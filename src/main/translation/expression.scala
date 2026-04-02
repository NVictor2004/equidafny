package translation.expression

import parsers.structure as Parsers
import translation.structure.*

import translation.types.translateType
import translation.pattern.translatePattern
import translation.index.translateIndex
import translation.structure.BinaryOperator.*
import translation.structure.UnaryOperator.*
import translation.structure.Quantifier.*
import translation.translation.Context

def translateExpr(expr: Parsers.ExprBlock)(using Context): ExprBlock = {
  val extendedExprs = expr.extendedExprs.map(translateExtendedExpr)
  val basicExpr = translateBasicExpr(expr.basicExpr)
  ExprBlock(extendedExprs, basicExpr)
}

def translateExtendedExpr(expr: Parsers.ExtendedExpr)(using Context): ExtendedExpr =
  expr match {
    case Parsers.MethodCall(name, args) =>
      MethodCall(name, args.map(translateBasicExpr))
    case Parsers.Let(left, right) =>
      Let(
        left.map { case (name, expr) => (name, expr.map(translateType)) },
        translateBasicExpr(right)
      )
    case Parsers.LetOrFail(left, leftType, right) =>
      LetOrFail(
        left,
        leftType.map(translateType),
        translateBasicExpr(right)
      )
    case Parsers.Assert(expr) => Assert(translateBasicExpr(expr))
  }

def translateLiteralExpr(literal: Parsers.LiteralExpr): LiteralExpr =
  literal match {
    case Parsers.BoolLiteral(value)   => BoolLiteral(value)
    case Parsers.CharLiteral(value)   => CharLiteral(value)
    case Parsers.IntLiteral(value)    => IntLiteral(value)
    case Parsers.StringLiteral(value) => StringLiteral(value)
    case Parsers.RealLiteral(value)   => RealLiteral(value)
    case Parsers.Null                 => Null
  }

def translateBasicExpr(expr: Parsers.BasicExpr)(using context: Context): BasicExpr = expr match {
  case literal: Parsers.LiteralExpr  => translateLiteralExpr(literal)
  case Parsers.Ident(name, suffixes) => Ident(name, suffixes)
  case Parsers.Cardinality(e)        => Cardinality(translateBasicExpr(e))
  case Parsers.Tuple(elements)       => Tuple(elements.map(translateBasicExpr))
  case Parsers.Iff(l, r)             =>
    Binary(Iff, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.LeftImplies(l, r) =>
    Binary(LeftImplies, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.RightImplies(l, r) =>
    Binary(RightImplies, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.BoolAnd(l, r) =>
    Binary(BoolAnd, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.BoolOr(l, r) =>
    Binary(BoolOr, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Eq(l, r) =>
    Binary(Eq, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Neq(l, r) =>
    Binary(Neq, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.LT(l, r) =>
    Binary(LT, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.LTE(l, r) =>
    Binary(LTE, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.GT(l, r) =>
    Binary(GT, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.GTE(l, r) =>
    Binary(GTE, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.In(l, r) =>
    Binary(In, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.NotIn(l, r) =>
    Binary(NotIn, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Disjoint(l, r) =>
    Binary(Disjoint, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.LeftShift(l, r) =>
    Binary(LeftShift, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.RightShift(l, r) =>
    Binary(RightShift, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Add(l, r) =>
    Binary(Add, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Sub(l, r) =>
    Binary(Sub, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Mul(l, r) =>
    Binary(Mul, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Div(l, r) =>
    Binary(Div, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Mod(l, r) =>
    Binary(Mod, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.BitOr(l, r) =>
    Binary(BitOr, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.BitAnd(l, r) =>
    Binary(BitAnd, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.BitXor(l, r) =>
    Binary(BitXor, translateBasicExpr(l), translateBasicExpr(r))
  case Parsers.Neg(e) => Unary(Neg, translateBasicExpr(e))
  case Parsers.Not(e) => Unary(Not, translateBasicExpr(e))
  case Parsers.Forall(variable, varType, body) =>
    Quantified(
      Forall,
      variable,
      varType.map(translateType),
      translateBasicExpr(body)
    )
  case Parsers.Exists(variable, varType, body) =>
    Quantified(
      Exists,
      variable,
      varType.map(translateType),
      translateBasicExpr(body)
    )

  // TODO: Move to optimisation pass?
  case Parsers.Cond(cond, Parsers.ExprBlock(Nil, thenBranch), Parsers.ExprBlock(Nil, Parsers.BoolLiteral(false))) => 
    Binary(BoolAnd, translateBasicExpr(cond), translateBasicExpr(thenBranch))
  case Parsers.Cond(cond, Parsers.ExprBlock(Nil, thenBranch), Parsers.ExprBlock(Nil, Parsers.BoolLiteral(true))) => 
    Binary(BoolOr, Unary(Not, translateBasicExpr(cond)), translateBasicExpr(thenBranch))
  case Parsers.Cond(cond, Parsers.ExprBlock(Nil, Parsers.BoolLiteral(false)), Parsers.ExprBlock(Nil, elseBranch)) => 
    Binary(BoolAnd, Unary(Not, translateBasicExpr(cond)), translateBasicExpr(elseBranch))
  case Parsers.Cond(cond, Parsers.ExprBlock(Nil, Parsers.BoolLiteral(true)), Parsers.ExprBlock(Nil, elseBranch)) => 
    Binary(BoolOr, translateBasicExpr(cond), translateBasicExpr(elseBranch))
  
  case Parsers.Cond(cond, thenBranch, elseBranch) =>
    Cond(
      translateBasicExpr(cond),
      translateExpr(thenBranch),
      translateExpr(elseBranch)
    )
  case Parsers.FunctionCall(name, args) => {
    context.functionData.get(name) match {
      case None => OtherFunctionCall(name, args.map(_.map(translateBasicExpr)))
      case Some(parameters) => {
        val first = args(0).map(translateBasicExpr).zip(parameters).map((expr, name) => (name, expr))
        val rest = args.tail.map(_.map(expr => ("_", translateBasicExpr(expr))))
        TrueFunctionCall(name, first :: rest)
      }
    }
  }
  case Parsers.LambdaCall(Parsers.Lambda(lvalues, body), args) =>
    LambdaCall(translateLambda(lvalues, body), args.map(translateBasicExpr))
  case Parsers.Match(expr, cases) =>
    Match(
      translateBasicExpr(expr),
      cases.map { case (pattern, body) =>
        (translatePattern(pattern), translateExpr(body))
      }
    )
  case Parsers.Set(elements)           => Set(elements.map(translateBasicExpr))
  case Parsers.Seq(elements)           => Seq(elements.map(translateBasicExpr))
  case Parsers.Lambda(lvalues, body)   => translateLambda(lvalues, body)
  case Parsers.SeqIndex(name, indexes) =>
    SeqIndex(name, indexes.map(translateIndex))
}

def translateLambda(
    lvalues: List[(String, Option[Parsers.Type])],
    body: Parsers.ExprBlock
)(using Context): Lambda = Lambda(
  lvalues.map { case (name, tpeOpt) => (name, tpeOpt.map(translateType)) },
  translateExpr(body)
)
