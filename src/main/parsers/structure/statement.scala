package parsers.structure

import parsley.templates.{PureParserBridge1, PureParserBridge2, PureParserBridge3}

sealed trait Stmt

case class CondStmt(cond: Expr, thenBranch: BlockStmt, elseBranch: Option[CondStmt | BlockStmt]) extends Stmt
object CondStmt extends PureParserBridge3[Expr, BlockStmt, Option[CondStmt | BlockStmt], CondStmt]
case class CallStmt(name: String, args: List[Expr]) extends Stmt
object CallStmt extends PureParserBridge2[String, List[Expr], CallStmt]
case class MatchStmt(expr: Expr, cases: List[(Pattern, List[Stmt])]) extends Stmt
object MatchStmt extends PureParserBridge2[Expr, List[(Pattern, List[Stmt]) ], MatchStmt]
case class AssertStmt(expr: Expr) extends Stmt
object AssertStmt extends PureParserBridge1[Expr, AssertStmt]
case class LetStmt(left: List[String], right: Expr) extends Stmt
object LetStmt extends PureParserBridge2[List[String], Expr, LetStmt]
case class LetOrFailStmt(left: String, right: Expr) extends Stmt
object LetOrFailStmt extends PureParserBridge2[String, Expr, LetOrFailStmt] 
case class BlockStmt(stmts: List[Stmt]) extends Stmt
object BlockStmt extends PureParserBridge1[List[Stmt], BlockStmt]