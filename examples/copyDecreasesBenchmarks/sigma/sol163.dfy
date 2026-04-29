import stainless.collection._
import stainless.lang._
object C_sigma_sol163 {
  def sigma(x: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b == a) {
      x(b)
    } else if (a > b) {
      BigInt(0)
    } else {
      x(a) + sigma(x, a + BigInt(1), b)
    }
  }
}
