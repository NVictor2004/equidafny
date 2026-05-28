package formatter.pattern

import translation.structure.*
import formatter.formatter.*
import formatter.expression.formatLiteral

// Function to format a match pattern
def formatPattern(pattern: Pattern)(using writer: Formatter): Unit =
  pattern match {
    case UnNamed             => writer.format("_")
    case Basic(name, values) => {
      writer.format(name)
      if (values != Nil) {
        formatBrackets("(", formatList(values, formatPattern), ")")
      }
    }
    case Constant(value)        => formatLiteral(value)
    case PatternTuple(elements) =>
      formatBrackets("(", formatList(elements, formatPattern), ")")
    case PatternIdent(value) => writer.format(value)
  }
