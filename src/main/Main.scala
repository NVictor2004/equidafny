import scala.sys.process._

@main
def main(file: String): Unit = {
  println("Processing file: " + file)

  val command = s"dafny $file"
  print(command.!!)
}
