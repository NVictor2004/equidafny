package parsers.structure

import parsley.templates.{PureParserBridge2, PureParserBridge3}

sealed trait Stmt

case class CondStmt(cond: Expr, thenBranch: List[Stmt], elseBranch: Option[CondStmt | List[Stmt]]) extends Stmt
object CondStmt extends PureParserBridge3[Expr, List[Stmt], Option[CondStmt | List[Stmt]], CondStmt]
case class CallStmt(name: String, args: List[Expr]) extends Stmt
object CallStmt extends PureParserBridge2[String, List[Expr], CallStmt]