import parsers.program.program
import translation.program.translateProgram
import optimisation.program.optimiseProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import ujson.*
import java.io.PrintWriter
import java.io.File
import scala.util.Random.shuffle

private val jpath1 = os.pwd / "src" / "test" / "json" / "copyDecreases"
private val jpath2 = os.pwd / "src" / "test" / "json" / "eqBench"
private val jpath3 = os.pwd / "src" / "test" / "json" / "selfWritten"
private val jpath4 = os.pwd / "src" / "test" / "json" / "stainless"
private val jpath5 = os.pwd / "src" / "test" / "json" / "counterExamples" / "stainless"
private val jpath6 = os.pwd / "src" / "test" / "json" / "counterExamples" / "eqBench"

private val dpath1 = os.pwd / "examples" / "copyDecreases" / "noHelp"
private val dpath2 = os.pwd / "examples" / "eqBench" / "noHelp"
private val dpath3 = os.pwd / "examples" / "selfWritten" / "noHelp"
private val dpath4 = os.pwd / "examples" / "stainless" / "noHelp"
private val dpath5 = os.pwd / "examples" / "counterExamples" / "stainless"
private val dpath6 = os.pwd / "examples" / "counterExamples" / "eqBench"

private val examples1 = os.walk(jpath1).filter(os.isFile(_)).map(jpath => (jpath, dpath1))
private val examples2 = os.walk(jpath2).filter(os.isFile(_)).map(jpath => (jpath, dpath2))
private val examples3 = os.walk(jpath3).filter(os.isFile(_)).map(jpath => (jpath, dpath3))
private val examples4 = os.walk(jpath4).filter(os.isFile(_)).map(jpath => (jpath, dpath4))
private val examples5 = os.walk(jpath5).filter(os.isFile(_)).map(jpath => (jpath, dpath5))
private val examples6 = os.walk(jpath6).filter(os.isFile(_)).map(jpath => (jpath, dpath6))

private val shuffledExamples = 
  shuffle(examples1 ++ examples2 ++ examples3 ++ examples4 ++ examples5 ++ examples6)

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

    writer.format("%d, %d, %d, %d, %d\n", parsingTime, translationTime, optimisationTime, equivalenceTime, formattingTime)
  })

  writer.close()
}
