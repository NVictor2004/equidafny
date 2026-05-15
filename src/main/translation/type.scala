package translation.types

import parsers.structure as Parsers
import translation.structure.*
import translation.translation.Context
import Parsers.NamedType

def translateDomainType(t: Parsers.DomainType)(using context: Context): DomainType = t match {
  case Parsers.TypeInt                   => TypeInt
  case Parsers.TypeBool                  => TypeBool
  case Parsers.TypeString                => TypeString
  case Parsers.TypeChar                  => TypeChar
  case Parsers.TypeNat                   => TypeNat
  case Parsers.SeqType(elementType)      => SeqType(translateType(elementType))
  case Parsers.SetType(elementType)      => SetType(translateType(elementType))
  case Parsers.NamedType(name, generics) =>
    if context.genericTypeData.contains(name) then GenericType(name) 
    else CreatedType(name, generics.fold(Nil)(_.map(translateType)))
  case Parsers.TupleType(elements) => TupleType(elements.map(translateType))
}

def translateType(t: Parsers.Type)(using context: Context): Type = t match {
  case t: Parsers.DomainType => translateDomainType(t)
  case Parsers.ArrowType(from, to) =>
    ArrowType(translateDomainType(from), translateType(to))
}
