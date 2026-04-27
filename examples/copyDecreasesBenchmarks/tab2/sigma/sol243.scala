import stainless.collection._
import stainless.lang._
object C_sigma_sol243 {
  def incr(n: BigInt) = { n + BigInt(1) }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(a) + sigma(f, incr(a), b)
    }
  }
}
