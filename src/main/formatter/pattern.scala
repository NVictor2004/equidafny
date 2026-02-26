package formatter.pattern

import translation.structure.*
import formatter.formatter.*
import formatter.expression.formatLiteral

def formatPattern(pattern: Pattern)(using writer: Formatter): Unit =
  pattern match {
    case UnNamed             => writer.format("_")
    case Basic(name, values) => {
      writer.format(name)
      values.foreach(list =>
        formatBrackets("(", formatList(list, formatPattern), ")")
      )
    }
    case Constant(value)        => formatLiteral(value)
    case PatternTuple(elements) =>
      formatBrackets("(", formatList(elements, formatPattern), ")")
  }
