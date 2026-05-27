import parsers.program.program
import translation.program.translateProgram
import optimisation.program.optimiseProgram
import formatter.program.formatProgram
import equivalence.program.programEquivalence

import ujson.*

@main
def main(jsonRelPath: String): Unit = {
  // Get JSON configuration
  val jsonPath = os.pwd / os.RelPath(jsonRelPath)
  val config = ujson.read(os.read(jsonPath))

  // Get Dafny source
  val dafnySourceFileName = config("file").str
  val dafnySourceFilePath = os.pwd / dafnySourceFileName
  val dafnySourceFile = os.read(dafnySourceFilePath)

  // Check that the provided Dafny source code compiles
  val checkDafnySource = os.proc("dafny", "resolve", dafnySourceFilePath.toString).call(check = false)
  if (checkDafnySource.exitCode != 0) {
    throw IllegalArgumentException("Dafny source file does not compile")
  }

  // Generate equivalence lemmas
  val parsedOutput = program.parse(dafnySourceFile).get
  val translatedOutput = translateProgram(parsedOutput, config)
  val optimisedOutput = optimiseProgram(translatedOutput)
  val equivalenceOutput = programEquivalence(optimisedOutput)

  val outputFilePath = os.pwd / dafnySourceFileName
  formatProgram(translatedOutput, equivalenceOutput, outputFilePath.toString)

  // Verify generated lemmas
  val verifyOutput = os.proc("dafny", "verify", outputFilePath.toString).call(check = false)
  if (verifyOutput.exitCode != 0) {
    throw IllegalArgumentException("Functions cannot be proven equivalent")
  }
}
