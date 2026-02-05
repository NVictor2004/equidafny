package formatter.types

import translation.structure.*
import formatter.program.Formatter

def formatType(t: Type)(using writer: Formatter): Unit = t match {
    case TypeInt => writer.print("int")
    case TypeBool => writer.print("bool")
    case TypeString => writer.print("string")
    case TypeChar => writer.print("char")
    case TypeNat => writer.print("nat")
    case SeqType(elementType) =>
        writer.format("seq<%s>", formatType(elementType))
    case SetType(elementType) =>
        writer.format("set<%s>", formatType(elementType))
    case NamedType(name, generics) => {
        writer.print(name)
        generics.foreach(genericList =>
            writer.print(genericList.map(formatType).mkString("(", ", ", ")"))
        )
    }
    case TupleType(elements) =>
        writer.print(elements.map(formatType).mkString("(", ", ", ")"))
    case ArrowType(from, to) =>
        writer.format("%s -> %s", formatType(from), formatType(to))
}