import stainless.collection._
import stainless.lang._
object C_sigma_sol23 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b < a) {
      BigInt(0)
    } else if (b == a) {
      f(a)
    } else {
      f(a) + sigma(f, a + BigInt(1), b)
    }
  }
}
