import stainless.collection._
import stainless.lang._
object C_sigma_sol669 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    val sum1 = BigInt(0)
    if (a > b) {
      sum1
    } else {
      val sum: BigInt = sum1 + f(a) + sigma(f, a + BigInt(1), b)
      sum
    }
  }
}
