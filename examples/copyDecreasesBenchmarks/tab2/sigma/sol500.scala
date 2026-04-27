import stainless.collection._
import stainless.lang._
object C_sigma_sol500 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def _sigma(a: BigInt, b: BigInt, r: BigInt): BigInt = {
      if (a > b) r else _sigma(a + BigInt(1), b, r + f(a))
    }
    _sigma(a, b, BigInt(0))
  }
}
