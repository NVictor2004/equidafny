package parsers.specification

import parsley.combinator.sepBy
import parsley.Parsley.many

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.basic

lazy val spec = many(
    Requires("requires" ~> basic)
    | Ensures("ensures" ~> basic)
    | Decreases("decreases" ~> sepBy(basic, ","))
)