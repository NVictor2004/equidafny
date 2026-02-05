package formatter.Index

import formatter.expression.formatBasicExpr
import formatter.program.Formatter
import translation.structure.*

def formatIndex(index: Index)(using writer: Formatter): Unit = index match {
    case ExprIndex(value) => formatBasicExpr(value)
    case StartSubIndex(value) => writer.format("%s ..", formatBasicExpr(value))
    case UpdateIndex(left, right) => writer.format("%s := %s", formatBasicExpr(left), formatBasicExpr(right))
}