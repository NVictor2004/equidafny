import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure

import parsers.program.program
import translation.program.translateProgram
import formatter.program.formatProgram

import os.proc
import org.scalatest.ParallelTestExecution

private val scalaPath = os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
private val outputPath = os.pwd / "src" / "test" / "out"
private val scalaDirectories = os.list(scalaPath).filter(_.baseName != "incomplete")
private val scalaExamples = scalaDirectories.flatMap(os.list(_))

class ScalaExamplesTest extends AnyFlatSpec with ParallelTestExecution {
  scalaExamples.foreach(example =>
    example.last should "be parsed and formatted correctly" in {
      val output = program.parse(os.read(example))

      output match {
        case Failure(msg) => fail(msg)
        case _            =>
      }

      val translatedOutput = translateProgram(output.get)
      val outputFilePath = outputPath / example.last
      formatProgram(translatedOutput, outputFilePath.toString)

      val result = proc("dafny", "resolve", "--allow-warnings", outputFilePath.toString).call()
      result.exitCode match {
        case 0 =>
        case code => fail(s"Dafny verification failed with exitcode $code")
      }
    }
  )
}
