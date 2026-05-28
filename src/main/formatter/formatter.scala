package formatter.formatter

import java.io.PrintWriter
import scala.annotation.tailrec

// Class to wrap around a Java PrintWriter
case class Formatter(writer: PrintWriter) {
  def print(str: String): Unit = writer.print(str)
  def println(str: String): Unit = writer.println(str)
  def format(str: String, args: Object*): Unit = writer.format(str, args*)
  def close(): Unit = writer.close()
}

// Helper function to wrap brackets around another formatting function call
def formatBrackets(open: String, middle: => Unit, close: String)(using
    writer: Formatter
): Unit = {
  writer.print(open)
  middle
  writer.print(close)
}

// Helper function to format a list of elements
// Requires a function that formats a single element
@tailrec
def formatList[A](list: List[A], formatElement: A => Unit, sep: String = ", ")(
    using writer: Formatter
): Unit = {
  list match {
    case Nil          => {}
    case head :: Nil  => formatElement(head)
    case head :: tail => {
      formatElement(head)
      writer.print(sep)
      formatList(tail, formatElement, sep)
    }
  }
}
