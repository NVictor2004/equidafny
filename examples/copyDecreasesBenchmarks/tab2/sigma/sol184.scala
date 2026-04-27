import stainless.collection._
import stainless.lang._
object C_sigma_sol184 {
  def sigma(f: BigInt => BigInt, n1: BigInt, n2: BigInt): BigInt = {
    def sigma_sub(cur: BigInt, n: BigInt, f: BigInt => BigInt): BigInt = {
      if (cur > n) BigInt(0)
      else if (cur == n) f(n) else f(cur) + sigma_sub(cur + BigInt(1), n, f)
    }
    if (n1 > n2) BigInt(0) else sigma_sub(n1, n2, f)
  }
}
