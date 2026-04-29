import stainless.collection._
import stainless.lang._
object C_sigma_sol455 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def help(a: BigInt, b: BigInt, f: BigInt => BigInt, r: BigInt): BigInt = {
      if (a == b) {
        f(a) + r
      } else if (a > b) {
        BigInt(0)
      } else {
        help(a + BigInt(1), b, f, r + f(a))
      }
    }
    help(a, b, f, BigInt(0))
  }
}
