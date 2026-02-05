package formatter.pattern

import translation.structure.*
import formatter.program.Formatter
import formatter.expression.formatLiteral

def formatPattern(pattern: Pattern)(using writer: Formatter): Unit = pattern match {
    case UnNamed => writer.format("_")
    case Basic(name, values) => {
        writer.format(name)
        values.foreach(patterns => 
            writer.print(patterns.map(formatPattern).mkString("(", ", ", ")"))
        )
        }
    case Constant(value) => formatLiteral(value)
    case PatternTuple(elements) => 
        writer.print(elements.map(formatPattern).mkString("(", ", ", ")"))
    }