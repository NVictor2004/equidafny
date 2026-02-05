package formatter.specification

import translation.structure.*
import formatter.program.Formatter
import formatter.expression.{formatBasicExpr, formatBasicExprList}

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
        formatBasicExprList(es)
    }
}