import stainless.collection._
import stainless.lang._
object C_sigma_sol230 {
  def sigma(func: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      func(a)
    } else {
      func(a) + sigma(func, a + BigInt(1), b)
    }
  }
}
