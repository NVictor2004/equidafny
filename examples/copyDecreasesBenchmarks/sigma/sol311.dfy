import stainless.collection._
import stainless.lang._
object C_sigma_sol311 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      val aa = a + BigInt(1)
      f(a) + sigma(f, aa, b)
    }
  }
}
