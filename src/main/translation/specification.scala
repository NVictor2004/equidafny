package translation.specification

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateBasicExpr
import translation.translation.Context

def translateSpec(spec: Parsers.Spec)(using Context): Spec = spec match {
  case Parsers.Requires(e)      => Requires(translateBasicExpr(e))
  case Parsers.Ensures(e)       => Ensures(translateBasicExpr(e))
  case Parsers.Decreases(exprs) => Decreases(exprs.map(translateBasicExpr))
}
