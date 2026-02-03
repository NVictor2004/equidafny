import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure

import parsers.program.program

class ScalaExamplesTest extends AnyFlatSpec {
  val scalaPath = os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
  val scalaDirectories = os.list(scalaPath).filter(_.baseName != "incomplete")
  val scalaExamples = scalaDirectories.flatMap(os.list(_))

  for (example <- scalaExamples) {
    example.baseName should "be parsed correctly" in {
      val output = program.parse(os.read(example))
      output match {
        case Failure(msg) => fail(msg)
        case _            =>
      }
    }
  }
}
