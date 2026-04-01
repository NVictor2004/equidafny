package translation.index

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateBasicExpr
import translation.translation.Context

def translateIndex(index: Parsers.Index)(using Context): Index = index match {
  case Parsers.ExprIndex(value)     => ExprIndex(translateBasicExpr(value))
  case Parsers.StartSubIndex(value) => StartSubIndex(translateBasicExpr(value))
  case Parsers.UpdateIndex(left, right) =>
    UpdateIndex(translateBasicExpr(left), translateBasicExpr(right))
}
