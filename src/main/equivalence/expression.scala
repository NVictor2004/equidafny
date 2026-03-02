package equivalence.expression

import translation.structure.*

def convertExprBlock(block: ExprBlock): List[Stmt] = {
    val ExprBlock(extended, basic) = block
    extended.map(convertExtendedExpr) ++ convertBasicExpr(basic)
}

private def convertExtendedExpr(expr: ExtendedExpr): Stmt = expr match {
    case MethodCall(name, args) => CallStmt(name, List(args))
    case Let(left, right) => LetStmt(left.map(_._1), right)
    case LetOrFail(left, _, right) => LetOrFailStmt(left, right)
    case Assert(expr) => AssertStmt(expr)
}

private def convertBasicExpr(expr: BasicExpr): List[Stmt] = expr match {
    case _: LiteralExpr => Nil
    case Binary(_, left, right) => convertBasicExpr(left) ++ convertBasicExpr(right)
    case Unary(_, expr) => convertBasicExpr(expr)
    case Quantified(_, _, _, body) => convertBasicExpr(body)
    case Ident(name, suffixes) => Nil
    case Cardinality(expr) => convertBasicExpr(expr)
    case Tuple(elements) => elements.flatMap(convertBasicExpr)
    case Brackets(expr) => convertBasicExpr(expr)
    case Cond(cond, thenBranch, elseBranch) => List(
        CondStmt(cond, BlockStmt(convertExprBlock(thenBranch)), Some(BlockStmt(convertExprBlock(thenBranch))))
    )
    case FunctionCall(name, args) => List(CallStmt(name, args))
    case LambdaCall(lambda, args) => args.flatMap(convertBasicExpr)
    case Match(expr, cases) => List(
        MatchStmt(expr, cases.map((pattern, block) => (pattern, convertExprBlock(block))))
        )
    case Set(elements) => elements.flatMap(convertBasicExpr)
    case Seq(elements) => elements.flatMap(convertBasicExpr)
    case Lambda(_, body) => convertExprBlock(body)
    case SeqIndex(_, indexes) => ???
}