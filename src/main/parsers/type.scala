package parsers.types

import parsley.Parsley

import scala.language.implicitConversions

import parsers.lexer.*
import parsers.lexer.implicits.implicitSymbol
import parsers.structure.*

lazy val typeParser: Parsley[Type] = 
    ("int" as TypeInt)
    | ("bool" as TypeBool)
    | ("string" as TypeString)
    | ("char" as TypeChar)