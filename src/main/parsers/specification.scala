package parsers.specification

import parsley.combinator.sepBy
import parsley.Parsley.many

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.basic

lazy val requires = Requires("requires" ~> basic)
lazy val ensures = Ensures("ensures" ~> basic)
lazy val decreases = Decreases("decreases" ~> sepBy(basic, ","))
lazy val spec = many(requires | ensures | decreases)