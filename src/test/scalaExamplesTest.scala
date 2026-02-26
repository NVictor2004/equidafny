import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure
import parsley.Success

import parsers.program.program
import translation.program.translateProgram
import formatter.program.formatProgram

import os.proc
import org.scalatest.ParallelTestExecution

import ujson.*

private val scalaPath =
  os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
private val outputPath = os.pwd / "src" / "test" / "out"
private val scalaDirectories =
  os.list(scalaPath).filter(_.baseName != "incomplete")
private val scalaExamples =
  scalaDirectories.flatMap(os.list(_)).filter(_.ext == "json")

class ScalaExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  scalaExamples.foreach(jsonPath =>
    jsonPath.last should "be parsed and formatted correctly" in {
      val config = ujson.read(os.read(jsonPath))
      val scalaFile = jsonPath / os.up / config("file").str

      val output = program.parse(os.read(scalaFile))

      val parsedOutput = output match {
        case Failure(msg)  => fail(msg)
        case Success(data) => data
      }

      val translatedOutput = translateProgram(parsedOutput)
      val outputFilePath = outputPath / scalaFile.last
      formatProgram(translatedOutput, outputFilePath.toString)

      val result =
        proc("dafny", "resolve", "--allow-warnings", outputFilePath.toString)
          .call()
      result.exitCode match {
        case 0    =>
        case code => fail(s"Dafny verification failed with exitcode $code")
      }
    }
  )
}
