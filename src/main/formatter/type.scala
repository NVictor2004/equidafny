package formatter.types

import translation.structure.*
import formatter.formatter.Formatter

def formatType(t: Type)(using writer: Formatter): Unit = t match {
  case TypeInt              => writer.print("int")
  case TypeBool             => writer.print("bool")
  case TypeString           => writer.print("string")
  case TypeChar             => writer.print("char")
  case TypeNat              => writer.print("nat")
  case SeqType(elementType) => {
    writer.print("seq<")
    formatType(elementType)
    writer.print(">")
  }
  case SetType(elementType) => {
    writer.print("set<")
    formatType(elementType)
    writer.print(">")
  }
  case NamedType(name, generics) => {
    writer.print(name)
    generics.foreach(types => {
      writer.print("<")
      formatTypeList(types)
      writer.print(">")
    })
  }
  case TupleType(elements) => {
    writer.print("(")
    formatTypeList(elements)
    writer.print(")")
  }
  case ArrowType(from, to) => {
    formatType(from)
    writer.print(" -> ")
    formatType(to)
  }
}

def formatTypeList(types: List[Type])(using writer: Formatter): Unit = {
  types match {
    case Nil          => {}
    case head :: Nil  => formatType(head)
    case head :: tail => {
      formatType(head)
      tail.foreach(t => {
        writer.print(", ")
        formatType(t)
      })
    }
  }
}
