package parsers.pattern

import parsley.Parsley
import parsley.combinator.{sepBy, option}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.literal

lazy val pattern: Parsley[Pattern] =
  ("_" as UnNamed)
    | Basic(ident, option("(" ~> sepBy(pattern, ",") <~ ")"))
    | Constant(literal)
    | PatternTuple("(" ~> sepBy(pattern, ",") <~ ")")
