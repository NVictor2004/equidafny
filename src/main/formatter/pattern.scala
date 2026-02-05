package formatter.pattern

import translation.structure.*
import formatter.program.Formatter
import formatter.expression.formatLiteral

def formatPattern(pattern: Pattern)(using writer: Formatter): Unit = pattern match {
    case UnNamed => writer.format("_")
    case Basic(name, values) => {
        writer.format(name)
        values.foreach(formatPatternList)
    }
    case Constant(value) => formatLiteral(value)
    case PatternTuple(elements) => formatPatternList(elements)
    }

def formatPatternList(patterns: List[Pattern])(using writer: Formatter): Unit = {
    writer.print("(")
    patterns match {
        case Nil => {}
        case head :: tail => {
            formatPattern(head)
            tail.foreach(pattern => {
                writer.print(", ")
                formatPattern(pattern)
            })
        }
    }
    writer.print(")")
}