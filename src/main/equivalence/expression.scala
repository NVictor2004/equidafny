package equivalence.expression

import translation.structure.*

def convertExprBlock(currentName: String, block: ExprBlock): (List[Stmt], List[Stmt]) = {
    val ExprBlock(extended, basic) = block
    (extended.map(convertExtendedExpr), convertBasicExpr(currentName, basic))
}

def concat(a: (List[Stmt], List[Stmt])): List[Stmt] = a._1 ++ a._2

private def convertExtendedExpr(expr: ExtendedExpr): Stmt = expr match {
    case MethodCall(name, args) => CallStmt(name, List(args))
    case Let(left, right) => LetStmt(left.map(_._1), right)
    case LetOrFail(left, _, right) => LetOrFailStmt(left, right)
    case Assert(expr) => AssertStmt(expr)
}

private def convertBasicExpr(currentName: String, expr: BasicExpr): List[Stmt] = expr match {
    case _: LiteralExpr => Nil
    case Binary(_, left, right) => convertBasicExpr(currentName, left) ++ convertBasicExpr(currentName, right)
    case Unary(_, expr) => convertBasicExpr(currentName, expr)
    case Quantified(_, _, _, body) => convertBasicExpr(currentName, body)
    case Ident(name, suffixes) => Nil
    case Cardinality(expr) => convertBasicExpr(currentName, expr)
    case Tuple(elements) => elements.flatMap(convertBasicExpr(currentName, _))
    case Brackets(expr) => convertBasicExpr(currentName, expr)
    case Cond(cond, thenBranch, elseBranch) => {
        val convertedThen = concat(convertExprBlock(currentName, thenBranch))
        val convertedElse = concat(convertExprBlock(currentName, elseBranch))

        if (convertedThen.isEmpty && convertedElse.isEmpty) {
            convertBasicExpr(currentName, cond)
        } else {
            List(CondStmt(cond, BlockStmt(convertedThen), Some(BlockStmt(convertedElse))))
        }
    }
    case FunctionCall(name, args) => if currentName == name then Nil else List(CallStmt(name, args))
    case LambdaCall(lambda, args) => args.flatMap(convertBasicExpr(currentName, _))
    case Match(expr, cases) => List(
        MatchStmt(expr, cases.map((pattern, block) => (pattern, concat(convertExprBlock(currentName, block)))))
        )
    case Set(elements) => elements.flatMap(convertBasicExpr(currentName, _))
    case Seq(elements) => elements.flatMap(convertBasicExpr(currentName, _))
    case Lambda(_, body) => concat(convertExprBlock(currentName, body))
    case SeqIndex(_, indexes) => Nil // TODO
}