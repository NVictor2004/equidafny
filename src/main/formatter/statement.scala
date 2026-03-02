package formatter.statement

import translation.structure.*
import formatter.formatter.*
import formatter.expression.formatBasicExpr
import formatter.pattern.formatPattern

def formatStmt(stmt: Stmt)(using writer: Formatter): Unit = stmt match {
  case CondStmt(cond, thenBranch, elseBranch) => {
    writer.print("if ")
    formatBasicExpr(cond)
    formatStmt(thenBranch)
    elseBranch.foreach(block => {
      writer.print("else ")
      formatStmt(block)
    })
  }
  case CallStmt(name, args) => {
    writer.format("%s", name)
    args.foreach(call => formatBrackets("(", formatList(call, formatBasicExpr), ")"))
    writer.print(";")
  }
  case MatchStmt(expr, cases) => {
    writer.print("match ")
    formatBasicExpr(expr)
    writer.println(" {")
    cases.foreach((pattern, stmts) => {
      writer.print("case ")
      formatPattern(pattern)
      writer.print(" =>")
      stmts.foreach(formatStmt)
    })
    writer.println("}")
  }
  case AssertStmt(expr) => {
    writer.print("assert ")
    formatBasicExpr(expr)
    writer.print(";")
  }
  case LetStmt(left, right) => {
    writer.format("var %s := ", left.mkString("(", ", ", ")"))
    formatBasicExpr(right)
    writer.print(";")
  }
  case LetOrFailStmt(left, right) => {
    writer.format("var %s :| ", left)
    formatBasicExpr(right)
    writer.print(";")
  }
  case BlockStmt(stmts) => formatBrackets("{", stmts.foreach(formatStmt), "}")
}
