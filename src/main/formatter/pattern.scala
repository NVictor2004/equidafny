package formatter.pattern

import translation.structure.*
import formatter.formatter.{Formatter, formatList}
import formatter.expression.formatLiteral

def formatPattern(pattern: Pattern)(using writer: Formatter): Unit =
  pattern match {
    case UnNamed             => writer.format("_")
    case Basic(name, values) => {
      writer.format(name)
      values.foreach(list => {
        writer.print("(")
        formatList(list, formatPattern)
        writer.print(")")
      })
    }
    case Constant(value)        => formatLiteral(value)
    case PatternTuple(elements) => {
      writer.print("(")
      formatList(elements, formatPattern)
      writer.print(")")
    }
  }
