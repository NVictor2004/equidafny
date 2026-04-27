import stainless.lang._
import stainless.math._
object C_sigma_sol1 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else {
      b - a match {
        case i if i == BigInt(0) => { f(b) }
        case _                   => { f(a) + sigma(f, a + BigInt(1), b) }
      }
    }
  }
}
