import stainless.collection._
import stainless.lang._
object C_sigma_sol677 {
  sealed case class Problem() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(b) + sigma(f, a, b - BigInt(1))
    }
  }
}
