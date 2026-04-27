import stainless.collection._
import stainless.lang._
object C_sigma_sol624 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma2(f: BigInt => BigInt, n: BigInt, s: BigInt): BigInt = {
      if (n <= b) sigma2(f, n + BigInt(1), s + f(n)) else s
    }
    sigma2(f, a, BigInt(0))
  }
}
