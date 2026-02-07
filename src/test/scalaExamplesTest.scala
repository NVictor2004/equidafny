import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure

import parsers.program.program
import translation.program.translateProgram
import formatter.program.formatProgram

import os.proc

class ScalaExamplesTest extends AnyFlatSpec {
  val scalaPath = os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
  val scalaDirectories = os.list(scalaPath).filter(_.baseName != "incomplete")
  val scalaExamples = scalaDirectories.flatMap(os.list(_))

  for (example <- scalaExamples) {
    val output = program.parse(os.read(example))

    example.baseName should "be parsed correctly" in {
      output match {
        case Failure(msg) => fail(msg)
        case _            =>
      }
    }

    val translatedOutput = translateProgram(output.get)
    val outputPath = os.pwd / "src" / "test" / "out" / (example.baseName + ".dfy")
    formatProgram(translatedOutput, outputPath.toString)

    it should "have correct syntax" in {
      val result = proc("dafny", "resolve", "--allow-warnings", outputPath.toString).call()
      result.exitCode match {
        case 0 =>
        case code => fail(s"Dafny verification failed with exitcode $code")
      }
    }
  }
}
