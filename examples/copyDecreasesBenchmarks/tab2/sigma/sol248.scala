import stainless.collection._
import stainless.lang._
object C_sigma_sol248 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma_sub(cur: BigInt, n: BigInt, f: BigInt => BigInt): BigInt = {
      if (cur > n) BigInt(0)
      else if (cur == n) f(n) else f(cur) + sigma_sub(cur + BigInt(1), n, f)
    }
    if (a > b) BigInt(0) else sigma_sub(a, b, f)
  }
}
