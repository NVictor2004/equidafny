package formatter.program

import translation.structure.*
import formatter.types.formatType
import formatter.specification.formatSpec
import formatter.expression.formatExpr
import formatter.statement.formatStmt
import formatter.formatter.{Formatter, formatList}

import java.io.{File, PrintWriter}

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
    writer.print("<")
    formatList(typeList, formatGeneric)
    writer.print(">")
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

private def formatParameter(parameter: Parameter)(using writer: Formatter): Unit = {
  val Parameter(name, paramType) = parameter
  writer.format("%s :", name)
  formatType(paramType)
}

def formatDeclaredType(
    declaredType: DeclaredType
)(using writer: Formatter): Unit = {
  val DeclaredType(name, typeParams) = declaredType
  writer.print(name)
  typeParams.foreach(params => {
    writer.print("(")
    formatList(params, formatParameter)
    writer.print(")")
  })
}

private def formatGeneric(generic: (String, Option[GOption]))(using writer: Formatter): Unit = {
  val (typeName, gOption) = generic
  writer.format("%s", typeName)
  gOption.foreach {
    case Equals => writer.print("(==)")
    case NotNew => writer.print("(!new)")
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
    formatList(typeList, formatGeneric)
    writer.print(">")
  })

  writer.print("(")
  formatList(params, formatParameter)
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
    formatList(typeList, formatGeneric)
    writer.print(">")
  })

  writer.print("(")
  formatList(params, formatParameter)
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
