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
    NotVerified: Set[String],
    shouldSucceed: Boolean
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
      .call(check = false)
  result.exitCode match {
    case 0 if !testConfig.shouldSucceed                => fail(s"Dafny verification succeeded but should have failed")
    case code if code != 0 && testConfig.shouldSucceed =>
      fail(s"Dafny verification failed with exitcode $code, but should have succeeded")
    case _ =>
  }
}

// Tests from Stainless

private val StainlessConfig = Config(
  os.pwd / "examples" / "stainless" / "noHelp",
  os.pwd / "src" / "test" / "output" / "stainless",
  Set(
    "auxiliaryLemma",
    "terminationAuxiliaryLemma",
    "terminationHelperEquivalenceInduction",
    "terminationInduction"
  ),
  true
)

private val stainlessJsonPath =
  os.pwd / "src" / "test" / "json" / "stainless"
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
  os.pwd / "examples" / "eqBench" / "noHelp",
  os.pwd / "src" / "test" / "output" / "eqBench",
  Set("auxiliaryLemmas", "auxiliaryLemmasAssumption", "auxiliaryLemmasAssumptionTermination", "terminationAuxiliaryLemmas", "terminationAuxiliaryLemmasInduction", "terminationHelperEquivalenceAuxiliaryLemmas", "automaticAssumption", "helperEquivalenceVarinlining"),
  true
)

private val EqBenchJsonPath =
  os.pwd / "src" / "test" / "json" / "eqBench"
private val EqBenchJsonFiles = os.walk(EqBenchJsonPath).filter(os.isFile(_))

class EqBenchExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  EqBenchJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), EqBenchConfig)
    }
  )
}

// Tests from Copy Decreases

private val CopyDecreasesConfig = Config(
  os.pwd / "examples" / "copyDecreases" / "noHelp",
  os.pwd / "src" / "test" / "output" / "copyDecreases",
  Set("terminationAuxiliaryLemmas", "terminationAuxiliaryLemmasInduction", "terminationHelperEquivalenceCandcopy"),
  true
)

private val CopyDecreasesJsonPath =
  os.pwd / "src" / "test" / "json" / "copyDecreases"
private val CopyDecreasesJsonFiles = os.walk(CopyDecreasesJsonPath).filter(os.isFile(_))

class CopyDecreasesExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  CopyDecreasesJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), CopyDecreasesConfig)
    }
  )
}

// Self-Written Tests

private val SelfWrittenConfig = Config(
  os.pwd / "examples" / "selfWritten" / "noHelp",
  os.pwd / "src" / "test" / "output" / "selfWritten",
  Set("terminationInduction", "typesInductionAuxiliaryLemma"),
  true
)

private val SelfWrittenJsonPath =
  os.pwd / "src" / "test" / "json" / "selfWritten"
private val SelfWrittenJsonFiles = os.walk(SelfWrittenJsonPath).filter(os.isFile(_))

class SelfWrittenExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  SelfWrittenJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), SelfWrittenConfig)
    }
  )
}

// Not equivalent tests from EqBench

private val NotEquivalentEqBenchConfig = Config(
  os.pwd / "examples" / "counterExamples" / "eqBench",
  os.pwd / "src" / "test" / "output" / "counterExamples" / "eqBench",
  Set(),
  false
)

private val NotEquivalentEqBenchPath =
  os.pwd / "src" / "test" / "json" / "counterExamples" / "eqBench"
private val NotEquivalentEqBenchJsonFiles = os.walk(NotEquivalentEqBenchPath).filter(os.isFile(_))

class NotEquivalentEqBenchExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  NotEquivalentEqBenchJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), NotEquivalentEqBenchConfig)
    }
  )
}

// Not equivalent tests from Stainless

private val NotEquivalentStainlessConfig = Config(
  os.pwd / "examples" / "counterExamples" / "stainless",
  os.pwd / "src" / "test" / "output" / "counterExamples" / "stainless",
  Set(),
  false
)

private val NotEquivalentStainlessPath =
  os.pwd / "src" / "test" / "json" / "counterExamples" / "stainless"
private val NotEquivalentStainlessJsonFiles = os.walk(NotEquivalentStainlessPath).filter(os.isFile(_))

class NotEquivalentStainlessExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  NotEquivalentStainlessJsonFiles.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      createTest(jsonPath, msg => fail(msg), NotEquivalentStainlessConfig)
    }
  )
}
