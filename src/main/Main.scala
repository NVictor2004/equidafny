import parsers.program.program
import translation.program.translateProgram
import optimisation.program.optimiseProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import ujson.*

@main
def main(jsonRelPath: String): Unit = {
  // Get JSON configuration
  val pathPwdtoJson = os.pwd / os.RelPath(jsonRelPath)
  val config = ujson.read(os.read(pathPwdtoJson))

  // Get path to Dafny source
  val pathJsonToDafnySource = os.RelPath(config("file").str)
  val pathPwdtoDafnySource = pathPwdtoJson / os.up / pathJsonToDafnySource

  // Check that the provided Dafny source code compiles
  val checkDafnySource = os.proc("dafny", "resolve", pathPwdtoDafnySource.toString).call(check = false)
  if (checkDafnySource.exitCode != 0) {
    throw IllegalArgumentException("Dafny source file does not compile")
  }

  // Generate equivalence lemmas
  val dafnySourceFile = os.read(pathPwdtoDafnySource)
  val parsedOutput = program.parse(dafnySourceFile).get
  val translatedOutput = translateProgram(parsedOutput, config)
  val optimisedOutput = optimiseProgram(translatedOutput)
  val equivalenceOutput = programEquivalence(optimisedOutput)

  val outputFilePath = pathPwdtoDafnySource / os.up / "output.dfy"
  formatProgram(translatedOutput, equivalenceOutput, outputFilePath.toString)

  // Verify generated lemmas
  val verifyOutput = os.proc("dafny", "verify", outputFilePath.toString).call(check = false)
  if (verifyOutput.exitCode != 0) {
    throw IllegalArgumentException("Functions cannot be proven equivalent")
  }
}
