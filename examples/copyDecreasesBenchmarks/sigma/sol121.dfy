import stainless.collection._
import stainless.lang._
object C_sigma_sol121 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b < a) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(a) + sigma(f, a + BigInt(1), b)
    }
  }
}
