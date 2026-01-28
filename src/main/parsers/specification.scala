package parsers.specification

import parsley.combinator.sepBy
import parsley.Parsley.many

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.expr

lazy val requires = Requires("requires" ~> expr)
lazy val ensures = Ensures("ensures" ~> expr)
lazy val decreases = Decreases("decreases" ~> sepBy(expr, ","))
lazy val spec = many(requires | ensures | decreases)