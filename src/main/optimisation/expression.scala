package optimisation.expression

import translation.structure.*
import translation.structure.BinaryOperator.*
import translation.structure.UnaryOperator.*

def optimiseExprBlock(block: ExprBlock): ExprBlock = 
    block.copy(basicExpr = optimiseBasicExpr(block.basicExpr))

// TODO: If statements can sometimes provide preconditions for function calls
private def optimiseBasicExpr(expr: BasicExpr): BasicExpr = expr match {
    // Optimisation cases
    case Binary(BoolAnd, Unary(Not, l), r) => 
        optimiseBasicExpr(Cond(l, ExprBlock(Nil, BoolLiteral(false)), ExprBlock(Nil, r)))
    case Binary(BoolAnd, l, Unary(Not, r)) => 
        optimiseBasicExpr(Cond(r, ExprBlock(Nil, BoolLiteral(false)), ExprBlock(Nil, l)))
    case Binary(BoolOr, l, r) => 
        optimiseBasicExpr(Cond(l, ExprBlock(Nil, BoolLiteral(true)), ExprBlock(Nil, r)))
    case Cond(cond, ExprBlock(Nil, thenBranch), ExprBlock(Nil, BoolLiteral(false))) => 
        optimiseBasicExpr(Binary(BoolAnd, cond, thenBranch))
    case Cond(Unary(Not, cond), thenBranch, elseBranch) => 
        optimiseBasicExpr(Cond(cond, elseBranch, thenBranch))

    // If no optimisation cases match, break expression into its constituent parts
    // and continue optimisation on the individual parts
    case expr: (LiteralExpr | Ident | SeqIndex) => expr
    case Binary(operator, left, right) => Binary(operator, optimiseBasicExpr(left), optimiseBasicExpr(right))
    case Unary(operator, expr) => Unary(operator, optimiseBasicExpr(expr))
    case Quantified(quantifier, variable, varType, body) =>
        Quantified(quantifier, variable, varType, optimiseBasicExpr(body))
    case Cardinality(expr) => Cardinality(optimiseBasicExpr(expr))
    case Tuple(elements) => Tuple(elements.map(optimiseBasicExpr))
    case Cond(cond, thenBranch, elseBranch) =>
        Cond(optimiseBasicExpr(cond), optimiseExprBlock(thenBranch), optimiseExprBlock(elseBranch))
    case TrueFunctionCall(name, args) =>
        TrueFunctionCall(name, args.map(_.map((name, arg) => (name, optimiseBasicExpr(arg)))))
    case OtherFunctionCall(name, args) =>
        OtherFunctionCall(name, args.map(_.map(optimiseBasicExpr)))
    case LambdaCall(lambda, args) =>
        LambdaCall(optimiseLambda(lambda), args.map(optimiseBasicExpr))
    case Match(expr, cases) =>
        Match(optimiseBasicExpr(expr), cases.map((pattern, block) => (pattern, optimiseExprBlock(block))))
    case Set(elements) =>
        Set(elements.map(optimiseBasicExpr))
    case Seq(elements) =>
        Seq(elements.map(optimiseBasicExpr))
    case lambda: Lambda => optimiseLambda(lambda)
}

private def optimiseLambda(lambda: Lambda): Lambda = {
    val Lambda(lvalues, body) = lambda
    Lambda(lvalues, optimiseExprBlock(body))
}