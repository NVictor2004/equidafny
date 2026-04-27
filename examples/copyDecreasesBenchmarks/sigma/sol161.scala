import stainless.collection._
import stainless.lang._
object C_sigma_sol161 {
  sealed case class INVALID_RANGE() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma_rec(
        sum: BigInt,
        i: BigInt,
        b: BigInt,
        f: BigInt => BigInt
    ): BigInt = {
      if (i < b) {
        sigma_rec(sum + f(i), i + BigInt(1), b, f)
      } else if (i == b) {
        sum + f(i)
      } else {
        BigInt(0)
      }
    }
    if (a > b) BigInt(0) else sigma_rec(BigInt(0), a, b, f)
  }
}
