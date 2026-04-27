import stainless.collection._
import stainless.lang._
object C_sigma_sol511 {
  def sigma(f1: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f1(b)
    } else {
      f1(a) + sigma(f1, a + BigInt(1), b)
    }
  }
}
