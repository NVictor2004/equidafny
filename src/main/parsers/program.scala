package parsers.program

import parsley.Parsley.many
import parsley.combinator.{sepBy, option}

import scala.language.implicitConversions

import parsers.structure.*
import parsers.lexer.ident
import parsers.lexer.implicits.implicitSymbol
import parsers.types.typeParser
import parsers.specification.spec
import parsers.expression.{expr, basic}
import parsers.statement.block
import parsers.lexer.fully

// Helper parsers
private val gOption =
  ("==" as Equals)
    | ("!new" as NotNew)

private val generics = option(
  "<" ~> sepBy(ident <~> option("(" ~> gOption <~ ")"), ",") <~ ">"
)
private val parameter = Parameter(ident, ":" ~> typeParser)
private val parameters = "(" ~> sepBy(parameter, ",") <~ ")"
private val declaredType = DeclaredType(ident, option(parameters))

// Helper parsers to parse each possible top level structure
private val function = Function(
  "function" ~> ident,
  generics,
  parameters,
  ":" ~> typeParser,
  spec,
  "{" ~> expr <~ "}"
)
private val ghostFunction = GhostFunction(
  "ghost" ~> "function" ~> ident,
  generics,
  parameters,
  ":" ~> typeParser,
  spec,
  "{" ~> expr <~ "}"
)
private val lemma =
  Lemma("lemma" ~> ident, generics, parameters, spec, option(block))
private val datatype =
  Datatype("datatype" ~> ident, generics, "=" ~> sepBy(declaredType, "|"))
private val topLevelConstant =
  TopLevelConstant("const" ~> ident, ":" ~> typeParser, ":=" ~> basic)

// Main parser to parse an entire program
val program = fully(many(datatype | function | ghostFunction | lemma | topLevelConstant))
