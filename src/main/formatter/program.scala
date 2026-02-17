package formatter.program

import translation.structure.*
import formatter.types.formatType
import formatter.specification.formatSpec
import formatter.expression.formatExpr
import formatter.statement.formatStmt
import formatter.formatter.{Formatter, formatList}

import java.io.{File, PrintWriter}
import formatter.formatter.formatBrackets

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

  generic.foreach(typeList => formatBrackets("<", formatList(typeList, formatGeneric), ">"))

  writer.print(" = ")
  formatList(types, formatDeclaredType, " | ")
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
  typeParams.foreach(params => 
    formatBrackets("(", formatList(params, formatParameter), ")")
  )
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

  if (ghost) writer.print("ghost ")

  writer.format("function %s", name)

  generic.foreach(typeList => formatBrackets("<", formatList(typeList, formatGeneric), ">"))

  formatBrackets("(", formatList(params, formatParameter), ")")

  writer.print(": ")
  formatType(returnType)

  writer.println("")

  specs.foreach(spec => {
    formatSpec(spec)
    writer.println("")
  })

  formatBrackets("{", formatExpr(body), "}")
}

def formatLemma(lemma: Lemma)(using writer: Formatter): Unit = {
  val Lemma(name, generic, params, specs, body) = lemma

  writer.format("lemma %s", name)

  generic.foreach(typeList => formatBrackets("<", formatList(typeList, formatGeneric), ">"))

  formatBrackets("(", formatList(params, formatParameter), ")")

  writer.println("")

  specs.foreach(spec => {
    formatSpec(spec)
    writer.println("")
  })

  body.foreach(block => formatBrackets("{", formatStmt(block), "}"))
}
