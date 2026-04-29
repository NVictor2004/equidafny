import stainless.collection._
import stainless.lang._
object C_sigma_sol45 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(func: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a < b) {
      func(a) + sigma(func, a + BigInt(1), b)
    } else if (a == b) {
      func(b)
    } else {
      BigInt(0)
    }
  }
}
