import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure
import parsley.Success

import parsers.program.program
import translation.program.translateProgram
import optimisation.program.optimiseProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import os.proc
import os.Path
import org.scalatest.ParallelTestExecution

import ujson.*

// Helper data structure to set test configurations
private case class Config(
  dafny: Path,
  output: Path,
  NotVerified: Set[String]
)

// Helper function to create a single test
private def createTest(jsonPath: Path, fail: (String) => Nothing, testConfig: Config): Unit = {
  val config = ujson.read(os.read(jsonPath))
  val dafnySourcePath = testConfig.dafny / config("file").str

  val output = program.parse(os.read(dafnySourcePath))

  val parsedOutput = output match {
    case Failure(msg)  => fail(msg)
    case Success(data) => data
  }

  val translatedOutput = translateProgram(parsedOutput, config)
  val optimisedOutput = optimiseProgram(translatedOutput)
  val equivalenceOutput = programEquivalence(optimisedOutput)

  val outputFilePath = testConfig.output / config("file").str
  formatProgram(translatedOutput, equivalenceOutput, outputFilePath.toString)

  val directoryName = (jsonPath / os.up).last
  val action =
    if (testConfig.NotVerified.contains(directoryName)) "resolve" else "verify"

  val result =
    proc("dafny", action, "--allow-warnings", outputFilePath.toString)
      .call()
  result.exitCode match {
    case 0    =>
    case code => fail(s"Dafny verification failed with exitcode $code")
  }
}

// Tests from Stainless

private val StainlessConfig = Config(
  os.pwd / "examples" / "scalaEquivalenceBenchmarkExamples" / "noHelp",
  os.pwd / "src" / "test" / "stainlessOutput",
  Set("auxiliaryLemma", "terminationAuxiliaryLemma", "terminationHelperEquivalenceInduction", "terminationInduction", "higherOrderHelperEquivalenceInduction")
)

private val stainlessJsonPath =
  os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
private val stainlessJsonFiles = os.walk(stainlessJsonPath).filter(os.isFile(_))

class ScalaExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  stainlessJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), StainlessConfig)
    }
  )
}

// Tests from EqBench

private val EqBenchConfig = Config(
  os.pwd / "examples" / "CIterationExamples" / "noHelp",
  os.pwd / "src" / "test" / "eqBenchOutput",
  Set("auxiliaryLemmas", "terminationAuxiliaryLemmas", "terminationHelperEquivalenceAuxiliaryLemmas")
)

private val EqBenchJsonPath =
  os.pwd / "src" / "test" / "CIterationExamples"
private val EqBenchJsonFiles = os.walk(EqBenchJsonPath).filter(os.isFile(_))

class EqBenchExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  EqBenchJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), EqBenchConfig)
    }
  )
}
