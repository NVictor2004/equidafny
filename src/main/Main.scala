import parsers.program.program
import translation.program.translateProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import ujson.*
private val jsonPath =
  os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
private val outputPath = os.pwd / "src" / "test" / "output"
private val dafnyPath =
  os.pwd / "examples" / "scalaEquivalenceBenchmarkExamples" / "noHelp"
private val scalaExamples = os.walk(jsonPath).filter(os.isFile(_))

// TODO: Parse with Dafny parser first
@main
def main(): Unit = {
  var totalParsing = 0.0
  var totalTranslation = 0.0
  var totalEquivalence = 0.0
  var totalFormatting = 0.0
  scalaExamples.foreach(jsonExample => {
    val config = ujson.read(os.read(jsonExample))
    val scalaFile = dafnyPath / config("file").str
    val file = os.read(scalaFile)

    var before = System.nanoTime
    val parsedOutput = program.parse(file).get
    var elapsed = System.nanoTime - before
    totalParsing += elapsed

    before = System.nanoTime
    val translatedOutput = translateProgram(parsedOutput, config)
    elapsed = System.nanoTime - before
    totalTranslation += elapsed

    before = System.nanoTime
    val equivalenceOutput = programEquivalence(translatedOutput)
    elapsed = System.nanoTime - before
    totalEquivalence += elapsed

    val outputFilePath = (outputPath / scalaFile.last).toString

    before = System.nanoTime
    formatProgram(equivalenceOutput, outputFilePath)
    elapsed = System.nanoTime - before
    totalFormatting += elapsed
  })
  val number = scalaExamples.length
  print(totalParsing / number, totalTranslation / number, totalEquivalence / number, totalFormatting / number)
}
