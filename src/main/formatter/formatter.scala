package formatter.formatter

import java.io.PrintWriter
import scala.annotation.tailrec

case class Formatter(writer: PrintWriter) {
  def print(str: String): Unit = writer.print(str)
  def println(str: String): Unit = writer.println(str)
  def format(str: String, args: Object*): Unit = writer.format(str, args*)
  def close(): Unit = writer.close()
}

@tailrec
def formatList[A](list: List[A], formatElement: A => Unit)(using writer: Formatter): Unit = {
  list match {
    case Nil          => {}
    case head :: Nil  => formatElement(head)
    case head :: tail => {
      formatElement(head)
      writer.print(", ")
      formatList(tail, formatElement)
    }
  }
}

