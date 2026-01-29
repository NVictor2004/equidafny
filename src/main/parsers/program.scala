package parsers.program

import parsley.Parsley.many
import parsley.combinator.{sepBy, option}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.ident
import parsers.lexer.implicits.implicitSymbol
import parsers.types.typeParser
import parsers.specification.spec
import parsers.expression.expr
import parsers.statement.block
import parsers.lexer.fully

lazy val gOption =
    ("==" as Equals)
    | ("!new" as NotNew)

lazy val generics = option("<" ~> sepBy(ident <~> option("(" ~> gOption <~ ")"), ",") <~ ">")

lazy val parameter = Parameter(ident, ":" ~> typeParser)
lazy val parameters = sepBy(parameter, ",")
lazy val declaredType = DeclaredType(ident, option("(" ~> parameters <~ ")"))

lazy val function = Function(
    "function" ~> ident, generics, "(" ~> parameters <~ ")", ":" ~> typeParser, spec, "{" ~> expr <~ "}"
    )

lazy val ghostFunction = GhostFunction(
    "ghost" ~> "function" ~> ident, generics, "(" ~> parameters <~ ")", ":" ~> typeParser, spec, "{" ~> expr <~ "}"
    )

lazy val lemma = Lemma("lemma" ~> ident, generics, "(" ~> parameters <~ ")", spec, option(block))

lazy val datatype = Datatype("datatype" ~> ident, generics, "=" ~> sepBy(declaredType, "|"))

lazy val program = fully(many(datatype | function | ghostFunction | lemma))