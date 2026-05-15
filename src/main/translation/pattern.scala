package translation.pattern

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateLiteralExpr
import translation.translation.Context

def translatePattern(pattern: Parsers.Pattern)(using context: Context): Pattern = pattern match {
  case Parsers.UnNamed             => UnNamed
  case Parsers.Constant(value)     => Constant(translateLiteralExpr(value))
  case Parsers.Basic(name, None) => 
    if context.datatypeData.contains(name) 
      then DatatypeConstant(name)
      else PatternIdent(name)
  case Parsers.Basic(name, Some(Nil)) => DatatypeConstant(name)
  case Parsers.Basic(name, Some(values)) =>
    Basic(name, values.map(translatePattern))
  case Parsers.PatternTuple(elements) =>
    PatternTuple(elements.map(translatePattern))
}
