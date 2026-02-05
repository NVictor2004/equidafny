package formatter.types

import translation.structure.*
import formatter.program.Formatter

def formatType(t: Type)(using writer: Formatter): Unit = t match {
    case TypeInt => writer.print("int")
    case TypeBool => writer.print("bool")
    case TypeString => writer.print("string")
    case TypeChar => writer.print("char")
    case TypeNat => writer.print("nat")
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
        generics.foreach(formatTypeList)
    }
    case TupleType(elements) => formatTypeList(elements)
    case ArrowType(from, to) => {
        formatType(from)
        writer.print(" -> ")
        formatType(to)
    }
}

def formatTypeList(types: List[Type])(using writer: Formatter): Unit = {
    writer.print("(")
    types match {
        case Nil => {}
        case head :: tail => {
            formatType(head)
            tail.foreach(t => {
                writer.print(", ")
                formatType(t)
            })
        }
    }
    writer.print(")")
}