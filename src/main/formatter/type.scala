package formatter.types

import translation.structure.*
import formatter.formatter.*

def formatDomainType(t: DomainType)(using writer: Formatter): Unit = t match {
  case TypeInt              => writer.print("int")
  case TypeBool             => writer.print("bool")
  case TypeString           => writer.print("string")
  case TypeChar             => writer.print("char")
  case TypeNat              => writer.print("nat")
  case TypeReal             => writer.print("real")
  case SeqType(elementType) => {
    writer.print("seq")
    formatBrackets("<", formatType(elementType), ">")
  }
  case SetType(elementType) => {
    writer.print("set")
    formatBrackets("<", formatType(elementType), ">")
  }
  case CreatedType(name, generics) => {
    writer.print(name)
    if (generics != Nil) {
      formatBrackets("<", formatList(generics, formatType), ">")
    }
  }
  case GenericType(name)   => writer.print(name)
  case TupleType(elements) =>
    formatBrackets("(", formatList(elements, formatType), ")")
}

def formatType(t: Type)(using writer: Formatter): Unit = t match {
  case t: DomainType       => formatDomainType(t)
  case ArrowType(from, to) => {
    formatDomainType(from)
    writer.print(" -> ")
    formatType(to)
  }
}
