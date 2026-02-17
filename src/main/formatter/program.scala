package formatter.program

import translation.structure.*
import formatter.types.formatType
import formatter.specification.formatSpec
import formatter.expression.formatExpr
import formatter.statement.formatStmt
import formatter.formatter.Formatter

import java.io.{File, PrintWriter}
import scala.annotation.tailrec

def formatProgram(program: Program, outputFilename: String): Unit = {
  given writer: Formatter = Formatter(new PrintWriter(new File(outputFilename)))

  val Program(datatypes, functions, lemmas) = program

  datatypes.foreach(formatDatatype)
  functions.foreach(formatFunction)
  lemmas.foreach(formatLemma)

  writer.close()
}

def formatDatatype(datatype: Datatype)(using writer: Formatter): Unit = {
  val Datatype(name, generic, types) = datatype

  writer.format("datatype %s", name)

  generic.foreach(typeList => {
    val genericOutput = typeList
      .map((t, o) => {
        val g = o
          .map {
            case Equals => "=="
            case NotNew => "!new"
          }
          .getOrElse("")
        s"$t$g"
      })
      .mkString("<", ", ", ">")
    writer.print(genericOutput)
  })

  writer.print(" = ")
  types match {
    case Nil          => {}
    case head :: tail => {
      formatDeclaredType(head)
      tail.foreach(declaredType => {
        writer.print(" | ")
        formatDeclaredType(declaredType)
      })
    }
  }
  writer.println("")
}

@tailrec
def formatParameterList(
    params: List[Parameter]
)(using writer: Formatter): Unit = params match {
  case Nil         => {}
  case head :: Nil => {
    val Parameter(paramName, paramType) = head
    writer.format("%s :", paramName)
    formatType(paramType)
  }
  case head :: tail => {
    val Parameter(paramName, paramType) = head
    writer.format("%s :", paramName)
    formatType(paramType)
    writer.print(", ")
    formatParameterList(tail)
  }
}

def formatDeclaredType(
    declaredType: DeclaredType
)(using writer: Formatter): Unit = {
  val DeclaredType(name, typeParams) = declaredType
  writer.print(name)
  typeParams.foreach(params => {
    writer.print("(")
    formatParameterList(params)
    writer.print(")")
  })
}

def formatGenericList(
    generic: List[(String, Option[GOption])]
)(using writer: Formatter): Unit = {
  generic match {
    case Nil         => {}
    case head :: Nil => {
      val (typeName, gOption) = head
      writer.format("%s", typeName)
      gOption.foreach {
        case Equals => writer.print("(==)")
        case NotNew => writer.print("(!new)")
      }
    }
    case head :: tail => {
      val (typeName, gOption) = head
      writer.format("%s", typeName)
      gOption.foreach {
        case Equals => writer.print("(==)")
        case NotNew => writer.print("(!new)")
      }
      writer.print(", ")
      formatGenericList(tail)
    }
  }
}

def formatFunction(function: Function)(using writer: Formatter): Unit = {
  val Function(ghost, name, generic, params, returnType, specs, body) = function

  if (ghost) {
    writer.print("ghost ")
  }

  writer.format("function %s", name)

  generic.foreach(typeList => {
    writer.print("<")
    formatGenericList(typeList)
    writer.print(">")
  })

  writer.print("(")
  formatParameterList(params)
  writer.print(")")

  writer.print(": ")
  formatType(returnType)

  writer.println("")

  specs.foreach(spec => {
    formatSpec(spec)
    writer.println("")
  })

  writer.println("{")
  formatExpr(body)
  writer.println("}")
}

def formatLemma(lemma: Lemma)(using writer: Formatter): Unit = {
  val Lemma(name, generic, params, specs, body) = lemma

  writer.format("lemma %s", name)

  generic.foreach(typeList => {
    writer.print("<")
    formatGenericList(typeList)
    writer.print(">")
  })

  writer.print("(")
  formatParameterList(params)
  writer.print(")")

  writer.println("")

  specs.foreach(spec => {
    formatSpec(spec)
    writer.println("")
  })

  body.foreach(block => {
    writer.println("{")
    formatStmt(block)
    writer.println("}")
  })
}
