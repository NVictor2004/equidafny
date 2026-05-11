package parsers.index

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.implicits.implicitSymbol
import parsers.expression.basic

val index =
    basic <**> (
      "..".as(StartSubIndex(_: BasicExpr))
      | ":=" ~> basic.map(rightBasic => ((leftBasic: BasicExpr) => UpdateIndex(leftBasic, rightBasic)))
      </> ((basic: BasicExpr) => ExprIndex(basic))
    )
