import stainless.collection._
import stainless.lang._
object C_sigma_sol43 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b == a) {
      f(a)
    } else if (b < a) {
      BigInt(0)
    } else {
      f(b) + sigma(f, a, b - BigInt(1))
    }
  }
}
