import parsers.program.program
import translation.program.translateProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import ujson.*

private val outputPath = os.pwd / "src" / "test" / "output"
private val dafnyPath =
  os.pwd / "examples" / "scalaEquivalenceBenchmarkExamples" / "noHelp"

// TODO: Parse with Dafny parser first
@main
def main(jsonFile: String): Unit = {
  val config = ujson.read(os.read(os.pwd / os.RelPath(jsonFile)))
  val scalaFile = dafnyPath / config("file").str

  val parsedOutput = program.parse(os.read(scalaFile)).get
  val translatedOutput = translateProgram(parsedOutput, config)
  val equivalenceOutput = programEquivalence(translatedOutput)

  val outputFilePath = outputPath / scalaFile.last
  formatProgram(equivalenceOutput, outputFilePath.toString)
}
