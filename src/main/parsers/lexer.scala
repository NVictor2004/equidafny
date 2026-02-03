package parsers.lexer

import parsley.Parsley
import parsley.token.{Lexer, Basic, Unicode}
import parsley.token.descriptions.*
import parsley.token.descriptions.BreakCharDesc
import parsley.token.descriptions.ExponentDesc
import parsley.token.descriptions.PlusSignPresence.Optional
import parsley.syntax.character.stringLift

import scala.language.implicitConversions

lazy val lexer = Lexer(desc)

lazy val integer = lexer.lexeme.integer.number
lazy val real = lexer.lexeme.real.number
lazy val ident = lexer.lexeme.names.identifier
lazy val char = lexer.lexeme.character.fullUtf16
lazy val string = lexer.lexeme.string.fullUtf16
lazy val bool = lexer.lexeme(("true" as true) | ("false" as false))
lazy val implicits = lexer.lexeme.symbol.implicits

def fully[A](p: Parsley[A]): Parsley[A] = lexer.fully(p)

private val IdentSpecialChars = Set('\'', '_', '?')
private val LiteralEscapeChars = Set('\'', '\"', '\\')
private val EscapeCharMapping: Map[String, Int] = Map(
  "n" -> '\n',
  "r" -> '\r',
  "t" -> '\t',
  "0" -> '\u0000'
)
private val IllegalGraphicChars: Set[Int] = Set('\'', '\"', '\\', '\r', '\n')

private val desc: LexicalDesc = LexicalDesc.plain.copy(
  nameDesc = NameDesc.plain.copy(
    identifierStart = Basic(c => c.isLetter || IdentSpecialChars.contains(c)),
    identifierLetter =
      Basic(c => c.isLetterOrDigit || IdentSpecialChars.contains(c))
  ),
  spaceDesc = SpaceDesc.plain.copy(
    lineCommentStart = "//",
    multiLineCommentStart = "/*",
    multiLineCommentEnd = "*/"
  ),
  symbolDesc = SymbolDesc(
    caseSensitive = true,
    hardKeywords = Set(
      "abstract",
      "allocated",
      "as",
      "assert",
      "assume",
      "bool",
      "break",
      "by",
      "calc",
      "case",
      "char",
      "class",
      "codatatype",
      "const",
      "constructor",
      "continue",
      "datatype",
      "decreases",
      "else",
      "ensures",
      "exists",
      "expect",
      "export",
      "extends",
      "false",
      "for",
      "forall",
      "fresh",
      "function",
      "ghost",
      "if",
      "imap",
      "import",
      "in",
      "include",
      "int",
      "invariant",
      "is",
      "iset",
      "iterator",
      "label",
      "lemma",
      "map",
      "match",
      "method",
      "modifies",
      "modify",
      "module",
      "multiset",
      "nameonly",
      "nat",
      "new",
      "newtype",
      "null",
      "object",
      "object?",
      "old",
      "opaque",
      "opened",
      "ORDINAL",
      "predicate",
      "print",
      "provides",
      "reads",
      "real",
      "refines",
      "requires",
      "return",
      "returns",
      "reveal",
      "reveals",
      "seq",
      "set",
      "static",
      "string",
      "then",
      "this",
      "trait",
      "true",
      "twostate",
      "type",
      "unchanged",
      "var",
      "while",
      "witness",
      "yield",
      "yields"
    ),
    hardOperators = Set()
  ),
  textDesc = TextDesc.plain.copy(
    graphicCharacter = Unicode(c => !IllegalGraphicChars.contains(c)),

    // TODO: Add support for Unicode characters
    escapeSequences = EscapeDesc.plain.copy(
      literals = LiteralEscapeChars,
      mapping = EscapeCharMapping
    )
  ),
  numericDesc = NumericDesc.plain.copy(
    literalBreakChar =
      BreakCharDesc.Supported('_', allowedAfterNonDecimalPrefix = false),
    leadingDotAllowed = true,
    trailingDotAllowed = true,
    integerNumbersCanBeOctal = false,
    hexadecimalLeads = Set('x'),
    decimalExponentDesc =
      ExponentDesc.Supported(false, Set('e'), 10, Optional, true)
  )
)
