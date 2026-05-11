import stainless.collection._
import stainless.lang._
object C_sigma_sol326 {
  def sigma(n: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a < b) {
      n(a) + sigma(n, a + BigInt(1), b)
    } else if (a > b) {
      BigInt(0)
    } else {
      n(b)
    }
  }
}
