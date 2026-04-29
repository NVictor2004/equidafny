import stainless.collection._
import stainless.lang._
object C_sigma_sol701 {
  def sigma(func: BigInt => BigInt, a: BigInt, n: BigInt): BigInt = {
    if (a > n) BigInt(0) else if (n == a) func(a) else func(n) + sigma(func, a, n - BigInt(1))
  }
}
