package translation.structure

sealed trait Stmt

case class CondStmt(
    cond: Expr,
    thenBranch: BlockStmt,
    elseBranch: Option[CondStmt | BlockStmt]
) extends Stmt
case class CallStmt(name: String, args: List[Expr]) extends Stmt
case class MatchStmt(expr: Expr, cases: List[(Pattern, List[Stmt])])
    extends Stmt
case class AssertStmt(expr: Expr) extends Stmt
case class LetStmt(left: List[String], right: Expr) extends Stmt
case class LetOrFailStmt(left: String, right: Expr) extends Stmt
case class BlockStmt(stmts: List[Stmt]) extends Stmt
