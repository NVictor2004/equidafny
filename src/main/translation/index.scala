package translation.index

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateBasicExpr

def translateIndex(index: Parsers.Index): Index = index match {
  case Parsers.ExprIndex(value)     => ExprIndex(translateBasicExpr(value))
  case Parsers.StartSubIndex(value) => StartSubIndex(translateBasicExpr(value))
  case Parsers.UpdateIndex(left, right) =>
    UpdateIndex(translateBasicExpr(left), translateBasicExpr(right))
}
