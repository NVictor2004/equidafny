import stainless.collection._
import stainless.lang._
object C_sigma_sol495 {
  def sigma(g: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      g(a)
    } else {
      sigma(g, a + BigInt(1), b) + g(a)
    }
  }
}
