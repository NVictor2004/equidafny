package parsers.function

import parsley.combinator.sepBy

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.ident
import parsers.lexer.implicits.implicitSymbol
import parsers.types.typeParser
import parsers.specification.spec
import parsers.expression.expr

lazy val parameter = Parameter(ident, ":" ~> typeParser)
lazy val parameters = sepBy(parameter, ",")

lazy val function = Function(
    "function" ~> ident, "(" ~> parameters <~ ")", ":" ~> typeParser, spec, "{" ~> expr <~ "}"
    )
