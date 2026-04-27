import stainless.collection._
import stainless.lang._
object C_sigma_sol498 {
  def sigma2(a: BigInt, b: BigInt, f: BigInt => BigInt, r: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a) + r
    } else {
      sigma2(a + BigInt(1), b, f, f(a) + r)
    }
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    sigma2(a, b, f, BigInt(0))
  }
}
