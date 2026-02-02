package parsers.index

import parsley.Parsley.atomic

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.basic

lazy val index =
  StartSubIndex(atomic(basic <~ ".."))
    | UpdateIndex(atomic(basic <~ ":="), basic)
    | ExprIndex(basic)
