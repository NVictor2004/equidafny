import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure
import parsley.Success

import parsers.program.program
import translation.program.translateProgram
import optimisation.program.optimiseProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import os.proc
import org.scalatest.ParallelTestExecution

import ujson.*

private val jsonPath =
  os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
private val outputPath = os.pwd / "src" / "test" / "output"
private val dafnyPath =
  os.pwd / "examples" / "scalaEquivalenceBenchmarkExamples" / "noHelp"
private val scalaExamples = os.walk(jsonPath).filter(os.isFile(_))

private val NotVerifiedDirs = Set("auxiliaryLemma", "terminationAuxiliaryLemma", "terminationHelperEquivalenceInduction", "terminationInduction", "higherOrderHelperEquivalenceInduction")

class ScalaExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  scalaExamples.foreach(jsonExample =>
    jsonExample.last should "be parsed and formatted correctly" in {
      val config = ujson.read(os.read(jsonExample))
      val scalaFile = dafnyPath / config("file").str

      val output = program.parse(os.read(scalaFile))

      val parsedOutput = output match {
        case Failure(msg)  => fail(msg)
        case Success(data) => data
      }

      val translatedOutput = translateProgram(parsedOutput, config)
      val optimisedOutput = optimiseProgram(translatedOutput)
      val equivalenceOutput = programEquivalence(optimisedOutput)

      val outputFilePath = outputPath / scalaFile.last
      formatProgram(translatedOutput, equivalenceOutput, outputFilePath.toString)

      val directoryName = (jsonExample / os.up).last
      val action =
        if (NotVerifiedDirs.contains(directoryName)) "resolve" else "verify"

      val result =
        proc("dafny", action, "--allow-warnings", outputFilePath.toString)
          .call()
      result.exitCode match {
        case 0    =>
        case code => fail(s"Dafny verification failed with exitcode $code")
      }
    }
  )
}
