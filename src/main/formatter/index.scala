package formatter.index

import formatter.expression.formatBasicExpr
import formatter.formatter.Formatter
import translation.structure.*

// Function to format an index
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
