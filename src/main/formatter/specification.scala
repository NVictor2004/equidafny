package translation.expression

import translation.structure.*
import formatter.program.Formatter
import formatter.expression.formatBasicExpr

def formatSpec(spec: Spec)(using writer: Formatter): Unit = spec match {
    case Requires(e) => writer.format("requires %s", formatBasicExpr(e))
    case Ensures(e) => writer.format("ensures %s", formatBasicExpr(e))
    case Decreases(es) => writer.format("decreases %s", es.map(formatBasicExpr).mkString(", "))
}