package formatter.program

import translation.structure.*
import formatter.types.formatType
import formatter.specification.formatSpec
import formatter.expression.formatExpr
import formatter.statement.formatStmt
import formatter.formatter.{Formatter, formatList}

import java.io.{File, PrintWriter}
import formatter.formatter.formatBrackets

// Main function to format a Program
// Outputs the original provided functions before optimisation changes
// And the generated equivalence lemmas
def formatProgram(
    originalProgram: Program,
    equivalenceProgram: Program,
    outputFilename: String
): Unit = {
  given writer: Formatter = Formatter(new PrintWriter(new File(outputFilename)))

  val Program(
    datatypes,
    constants,
    modelFunction,
    candidateFunctions,
    helperFunctions,
    normFunction,
    typeFunctions,
    _,
    _,
    auxiliaryLemmas
  ) = originalProgram

  val Program(_, _, _, _, _, _, _, mainLemmas, helperLemmas, _) = equivalenceProgram

  datatypes.foreach(formatDatatype)
  constants.foreach(formatTopLevelConstant)
  formatFunction(modelFunction)
  candidateFunctions.foreach(formatFunction)
  helperFunctions.values.foreach(formatFunction)
  normFunction.foreach(formatFunction)
  typeFunctions.values.foreach(formatFunction)
  mainLemmas.foreach(formatLemma)
  helperLemmas.foreach(formatLemma)
  auxiliaryLemmas.foreach(formatLemma)

  writer.close()
}

// Function to format a top-level constant declaration
def formatTopLevelConstant(const: TopLevelConstant)(using writer: Formatter): Unit = {
  val TopLevelConstant(name, t, data) = const
  writer.format("const %s: ", name)
  formatType(t)
  writer.print(" := [")
  data.init.foreach(num => {
    writer.print(num.toString())
    writer.print(", ")
  })
  writer.print(data.last.toString())
  writer.print("]\n\n")
}

// Function to format a top-level datatype declaration
def formatDatatype(datatype: Datatype)(using writer: Formatter): Unit = {
  val Datatype(name, generic, types) = datatype

  writer.format("datatype %s", name)
  if (generic != Nil) {
    formatBrackets("<", formatList(generic, formatGeneric), ">")
  }
  writer.print(" = ")
  formatList(types, formatDeclaredType, " | ")
  writer.print("\n\n")
}

// Helper function to format a pair of an identifier and its type
private def formatNameTypePair(
  pair: (String, Type)
)(using writer: Formatter): Unit = {
  writer.format("%s: ", pair._1)
  formatType(pair._2)
}

def formatDeclaredType(
    declaredType: DeclaredType
)(using writer: Formatter): Unit = {
  val DeclaredType(name, typeParams) = declaredType
  writer.print(name)
  if (!typeParams.isEmpty) {
    formatBrackets("(", formatList(typeParams.toList, formatNameTypePair), ")")
  }
}

private def formatGeneric(
    generic: (String, Option[GOption])
)(using writer: Formatter): Unit = {
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

  if (generic != Nil) {
    formatBrackets("<", formatList(generic, formatGeneric), ">")
  }

  formatBrackets("(", formatList(params.toList, formatNameTypePair), ")")
  writer.print(": ")
  formatType(returnType)

  writer.println("")

  specs.foreach(spec => {
    formatSpec(spec)
    writer.println("")
  })

  formatBrackets("{", formatExpr(body), "}")

  writer.print("\n\n")
}

def formatLemma(lemma: Lemma)(using writer: Formatter): Unit = {
  val Lemma(name, generic, params, specs, body) = lemma

  writer.print("lemma ")

  if (body == None) {
    writer.print("{:axiom} ")
  }

  writer.format("%s", name)

  if (generic != Nil) {
    formatBrackets("<", formatList(generic, formatGeneric), ">")
  }

  formatBrackets("(", formatList(params.toList, formatNameTypePair), ")")

  writer.println("")

  specs.foreach(spec => {
    formatSpec(spec)
    writer.println("")
  })

  body.foreach(block => formatBrackets("{", formatStmt(block), "}"))

  writer.print("\n\n")
}
