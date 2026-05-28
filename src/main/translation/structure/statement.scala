package translation.structure

sealed trait Stmt

// Structures for each possible type of statement
case class CondStmt(
    cond: BasicExpr,
    thenBranch: BlockStmt,
    elseBranch: Option[CondStmt | BlockStmt]
) extends Stmt
case class CallStmt(name: String, args: List[List[BasicExpr]]) extends Stmt
case class MatchStmt(expr: BasicExpr, cases: List[(Pattern, List[Stmt])]) extends Stmt
case class AssertStmt(expr: BasicExpr) extends Stmt
case class LetStmt(left: List[String], right: BasicExpr) extends Stmt
case class LetOrFailStmt(left: String, right: BasicExpr) extends Stmt
case class BlockStmt(stmts: List[Stmt]) extends Stmt
