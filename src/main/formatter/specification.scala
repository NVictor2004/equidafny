package formatter.specification

import translation.structure.*
import formatter.formatter.{Formatter, formatList, formatBrackets}
import formatter.expression.formatBasicExpr

def formatSpec(spec: Spec)(using writer: Formatter): Unit = spec match {
  case Requires(e) => {
    writer.print("requires ")
    formatBasicExpr(e)
  }
  case Ensures(e) => {
    writer.print("ensures ")
    formatBasicExpr(e)
  }
  case Decreases(es) => {
    writer.print("decreases ")
    formatBrackets("(", formatList(es, formatBasicExpr), ")")
  }
}
