import org.scalatest.flatspec.AnyFlatSpec

import parsley.Failure

import parsers.program.program

class ParserTestSuite extends AnyFlatSpec {
  val scalaPath = os.pwd / "src" / "test" / "scalaEquivalenceBenchmarkExamples"
  val scalaExamples = os.walk(scalaPath).filter(os.isFile)

  for (example <- scalaExamples) {
    example.baseName should "be parsed correctly" in {
      val output = program.parse(os.read(example))
      output match {
        case Failure(msg) => fail(msg)
        case _ =>
      }
    }
  }
}
