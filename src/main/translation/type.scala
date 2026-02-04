package translation.types

import parsers.structure as Parsers
import translation.structure.*

def translateType(t: Parsers.Type): Type = t match {
  case Parsers.TypeInt                   => TypeInt
  case Parsers.TypeBool                  => TypeBool
  case Parsers.TypeString                => TypeString
  case Parsers.TypeChar                  => TypeChar
  case Parsers.TypeNat                   => TypeNat
  case Parsers.SeqType(elementType)      => SeqType(translateType(elementType))
  case Parsers.SetType(elementType)      => SetType(translateType(elementType))
  case Parsers.NamedType(name, generics) =>
    NamedType(name, generics.map(_.map(translateType)))
  case Parsers.TupleType(elements) => TupleType(elements.map(translateType))
  case Parsers.ArrowType(from, to) =>
    ArrowType(translateType(from), translateType(to))
}
