package formatter.program

import translation.structure.*
import java.io.{File, PrintWriter}

case class Formatter(writer: PrintWriter) {
    def print(str: String): Unit = writer.print(str)
    def println(str: String): Unit = writer.println(str)
    def format(str: String, args: Any*): Unit = writer.format(str, args)
    def close(): Unit = writer.close()
}

def formatProgram(program: Program, outputFilename: String): Unit = {
    given writer: Formatter = Formatter(new PrintWriter(new File(outputFilename)))

    val Program(datatypes, functions, ghostFunctions, lemmas) = program

    datatypes.foreach(formatDatatype)
    functions.foreach(formatFunction)
    ghostFunctions.foreach(formatGhostFunction)
    lemmas.foreach(formatLemma)

    writer.close()
}

def formatDatatype(datatype: Datatype)(using writer: Formatter): Unit = {
    val Datatype(name, generic, types) = datatype

    writer.format("datatype %s", name)

    generic.foreach(typeList => {
        val genericOutput = typeList.map((t, o) => {
            val g = o.map {
                case Equals => "=="
                case NotNew => "!new"
            }.getOrElse("")
            s"$t$g"
        }).mkString("<", ", ", ">")
        writer.print(genericOutput)
    })
    
    writer.print(" = ")
    writer.println(types.map(formatDeclaredType).mkString(" | "))
}

def formatDeclaredType(declaredType: DeclaredType)(using writer: Formatter): Unit = ???
def formatFunction(function: Function)(using writer: Formatter): Unit = ???
def formatGhostFunction(ghostFunction: GhostFunction)(using writer: Formatter): Unit = ???
def formatLemma(lemma: Lemma)(using writer: Formatter): Unit = ???