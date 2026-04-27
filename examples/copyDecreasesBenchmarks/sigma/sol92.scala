import stainless.collection._
import stainless.lang._
object C_sigma_sol92 {
  sealed case class Error(param0: BigInt, param1: BigInt) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a == b) {
      f(a)
    } else if (a < b) {
      f(a) + sigma(f, a + BigInt(1), b)
    } else {
      BigInt(0)
    }
  }
}
