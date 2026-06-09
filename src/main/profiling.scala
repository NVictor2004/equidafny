import parsers.program.program
import translation.program.translateProgram
import optimisation.program.optimiseProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import ujson.*
import java.io.PrintWriter
import java.io.File
import scala.util.Random.shuffle

private val jsonDafnyPaths = List(
  ("copyDecreases", "copyDecreases/noHelp"),
  ("eqBench", "eqBench/noHelp"),
  ("selfWritten", "selfWritten/noHelp"),
  ("stainless", "stainless/noHelp"),
  ("counterExamples/stainless", "counterExamples/stainless"),
  ("counterExamples/eqBench", "counterExamples/eqBench")
)

private val shuffledExamples = shuffle(jsonDafnyPaths.flatMap((json, dafny) => {
  val jsonPath = os.pwd / "src" / "test" / "json" / os.RelPath(json)
  val dafnyPath = os.pwd / "examples" / os.RelPath(dafny)
  os.walk(jsonPath).filter(os.isFile(_)).map((_, dafnyPath))
}))

// Function to time how long EquiDafny's 5 internal phases take
// The phases are Parsing, Translation, Optimisation, Lemma Generation and Formatting
// For each test, the time taken for each of the 5 phases is outputted to a file
def profile(): Unit = {
  val writer = new PrintWriter(new File("output.txt"))

  shuffledExamples.foreach((jsonExample, dpath) => {
    val config = ujson.read(os.read(jsonExample))
    val scalaFile = dpath / config("file").str
    val file = os.read(scalaFile)

    val parsingBefore = System.nanoTime
    val parsedOutput = program.parse(file).get
    val parsingTime = System.nanoTime - parsingBefore

    val translationBefore = System.nanoTime
    val translatedOutput = translateProgram(parsedOutput, config)
    val translationTime = System.nanoTime - translationBefore

    val optimisationBefore = System.nanoTime
    val optimisedOutput = optimiseProgram(translatedOutput)
    val optimisationTime = System.nanoTime - optimisationBefore

    val equivalenceBefore = System.nanoTime
    val equivalenceOutput = programEquivalence(optimisedOutput)
    val equivalenceTime = System.nanoTime - equivalenceBefore

    val outputFilePath = (os.pwd / config("file").str).toString

    val formattingBefore = System.nanoTime
    formatProgram(translatedOutput, equivalenceOutput, outputFilePath)
    val formattingTime = System.nanoTime - formattingBefore

    writer.format(
      "%d, %d, %d, %d, %d\n",
      parsingTime,
      translationTime,
      optimisationTime,
      equivalenceTime,
      formattingTime
    )
  })

  writer.close()
}
