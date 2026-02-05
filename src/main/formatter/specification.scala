package formatter.specification

import translation.structure.*
import formatter.program.Formatter
import formatter.expression.{formatBasicExpr, formatBasicExprList}

def formatSpec(spec: Spec)(using writer: Formatter): Unit = spec match {
    case Requires(e) => writer.format("requires %s", formatBasicExpr(e))
    case Ensures(e) => writer.format("ensures %s", formatBasicExpr(e))
    case Decreases(es) => {
        writer.print("decreases ")
        formatBasicExprList(es)
    }
}