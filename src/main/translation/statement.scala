package translation.statement

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateBasicExpr
import translation.pattern.translatePattern
import translation.translation.Context

def translateStmt(stmt: Parsers.Stmt)(using Context): Stmt = stmt match {
  case Parsers.CondStmt(cond, Parsers.BlockStmt(stmts), elseBranch) =>
    CondStmt(
      translateBasicExpr(cond),
      translateBlockStmt(stmts),
      elseBranch.map(translateElseBranch)
    )
  case Parsers.CallStmt(name, args) =>
    CallStmt(name, List(args.map(translateBasicExpr)))
  case Parsers.MatchStmt(expr, cases) =>
    MatchStmt(
      translateBasicExpr(expr),
      cases.map { case (pattern, stmts) =>
        (translatePattern(pattern), stmts.map(translateStmt))
      }
    )
  case Parsers.AssertStmt(expr) =>
    AssertStmt(translateBasicExpr(expr))
  case Parsers.LetStmt(left, right) =>
    LetStmt(left, translateBasicExpr(right))
  case Parsers.LetOrFailStmt(left, right) =>
    LetOrFailStmt(left, translateBasicExpr(right))
  case Parsers.BlockStmt(stmts) =>
    translateBlockStmt(stmts)
}

def translateBlockStmt(stmts: List[Parsers.Stmt])(using Context): BlockStmt =
  BlockStmt(stmts.map(translateStmt))

def translateElseBranch(
    branch: Parsers.CondStmt | Parsers.BlockStmt
)(using Context): CondStmt | BlockStmt = branch match {
  case Parsers.CondStmt(cond, Parsers.BlockStmt(stmts), elseBranch) =>
    CondStmt(
      translateBasicExpr(cond),
      translateBlockStmt(stmts),
      elseBranch.map(translateElseBranch)
    )
  case Parsers.BlockStmt(stmts) =>
    translateBlockStmt(stmts)
}
