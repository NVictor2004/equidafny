package evaluation.statement

import translation.structure.*
import evaluation.expression.evaluateBasicExpr
import evaluation.pattern.evaluatePattern
import evaluation.config.*

def evaluateStatement(stmt: Stmt): Double = stmt match {
  case AssertStmt(expr)                       => AssertCost + evaluateBasicExpr(expr)
  case CondStmt(cond, thenBranch, elseBranch) =>
    CondCost + evaluateStatement(thenBranch) + elseBranch.fold(0.0)(
      evaluateStatement
    )
  case CallStmt(_, args)      => CallCost + args.flatMap(_.map(evaluateBasicExpr)).sum
  case MatchStmt(expr, cases) =>
    MatchCost + evaluateBasicExpr(expr) + cases
      .map((pattern, stmts) => evaluatePattern(pattern) + stmts.map(evaluateStatement).sum)
      .sum
  case LetStmt(_, right)       => LetCost + evaluateBasicExpr(right)
  case LetOrFailStmt(_, right) => LetOrFailCost + evaluateBasicExpr(right)
  case BlockStmt(stmts)        => stmts.map(evaluateStatement).sum
}
