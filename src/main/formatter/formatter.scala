package formatter.formatter

import java.io.PrintWriter
import scala.annotation.tailrec

case class Formatter(writer: PrintWriter) {
  def print(str: String): Unit = writer.print(str)
  def println(str: String): Unit = writer.println(str)
  def format(str: String, args: Object*): Unit = writer.format(str, args*)
  def close(): Unit = writer.close()
}

def formatBrackets(open: String, middle: => Unit, close: String)(using
    writer: Formatter
): Unit = {
  writer.print(open)
  middle
  writer.print(close)
}

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
