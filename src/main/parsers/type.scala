package parsers.types

import parsley.Parsley
import parsley.combinator.{sepBy, option}

import scala.language.implicitConversions

import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.structure.*

// Helper parser to parse a domain type
private lazy val domainType: Parsley[DomainType] =
  ("int" as TypeInt)
    | ("bool" as TypeBool)
    | ("string" as TypeString)
    | ("char" as TypeChar)
    | ("nat" as TypeNat)
    | ("real" as TypeReal)
    | SeqType("seq" ~> "<" ~> typeParser <~ ">")
    | SetType("set" ~> "<" ~> typeParser <~ ">")
    | TupleType("(" ~> sepBy(typeParser, ",") <~ ")")
    | NamedType(ident, option("<" ~> sepBy(typeParser, ",") <~ ">"))

// Parser to parse any type
lazy val typeParser: Parsley[Type] = domainType <**> (
  "->" ~> typeParser.map(rightType => ((leftType: DomainType) => ArrowType(leftType, rightType)))
  </> identity[Type]
)
