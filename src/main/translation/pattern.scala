package translation.pattern

import parsers.structure as Parsers
import translation.structure.*
import translation.expression.translateLiteralExpr

def translatePattern(pattern: Parsers.Pattern): Pattern = pattern match {
  case Parsers.UnNamed             => UnNamed
  case Parsers.Constant(value)     => Constant(translateLiteralExpr(value))
  case Parsers.Basic(name, values) =>
    Basic(name, values.map(_.map(translatePattern)).getOrElse(Nil))
  case Parsers.PatternTuple(elements) =>
    PatternTuple(elements.map(translatePattern))
}
