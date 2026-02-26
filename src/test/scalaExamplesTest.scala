import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure
import parsley.Success

import parsers.program.program
import translation.program.translateProgram
import formatter.program.formatProgram

import os.proc
import org.scalatest.ParallelTestExecution

private val scalaPath =
  os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
private val outputPath = os.pwd / "src" / "test" / "out"
private val scalaDirectories =
  os.list(scalaPath).filter(_.baseName != "incomplete")
private val scalaExamples =
  scalaDirectories.flatMap(os.list(_)).filter(_.ext == "dfy")

class ScalaExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  scalaExamples.foreach(example =>
    example.last should "be parsed and formatted correctly" in {
      val output = program.parse(os.read(example))

      val parsedOutput = output match {
        case Failure(msg)  => fail(msg)
        case Success(data) => data
      }

      val translatedOutput = translateProgram(parsedOutput)
      val outputFilePath = outputPath / example.last
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
