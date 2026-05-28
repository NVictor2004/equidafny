package parsers.structure

import parsley.templates.{
  PureParserBridge1,
  PureParserBridge2,
  PureParserBridge3
}

sealed trait Stmt

// Structures for each possible type of statement
case class CondStmt(
    cond: BasicExpr,
    thenBranch: BlockStmt,
    elseBranch: Option[CondStmt | BlockStmt]
) extends Stmt
object CondStmt
    extends PureParserBridge3[BasicExpr, BlockStmt, Option[
      CondStmt | BlockStmt
    ], CondStmt]
case class CallStmt(name: String, args: List[BasicExpr]) extends Stmt
object CallStmt extends PureParserBridge2[String, List[BasicExpr], CallStmt]
case class MatchStmt(expr: BasicExpr, cases: List[(Pattern, List[Stmt])])
    extends Stmt
object MatchStmt
    extends PureParserBridge2[BasicExpr, List[(Pattern, List[Stmt])], MatchStmt]
case class AssertStmt(expr: BasicExpr) extends Stmt
object AssertStmt extends PureParserBridge1[BasicExpr, AssertStmt]
case class LetStmt(left: List[String], right: BasicExpr) extends Stmt
object LetStmt extends PureParserBridge2[List[String], BasicExpr, LetStmt]
case class LetOrFailStmt(left: String, right: BasicExpr) extends Stmt
object LetOrFailStmt extends PureParserBridge2[String, BasicExpr, LetOrFailStmt]
case class BlockStmt(stmts: List[Stmt]) extends Stmt
object BlockStmt extends PureParserBridge1[List[Stmt], BlockStmt]
