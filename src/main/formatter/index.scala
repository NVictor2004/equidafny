package formatter.index

import formatter.expression.formatBasicExpr
import formatter.program.Formatter
import translation.structure.*

def formatIndex(index: Index)(using writer: Formatter): Unit = index match {
  case ExprIndex(value)     => formatBasicExpr(value)
  case StartSubIndex(value) => {
    formatBasicExpr(value)
    writer.print(" ..")
  }
  case UpdateIndex(left, right) => {
    formatBasicExpr(left)
    writer.print(" := ")
    formatBasicExpr(right)
  }
}
