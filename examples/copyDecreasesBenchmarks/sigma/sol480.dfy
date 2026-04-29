import stainless.collection._
import stainless.lang._
object C_sigma_sol480 {
  def sigma(f: BigInt => BigInt, n: BigInt, m: BigInt): BigInt = {
    if (n <= m) f(n) + sigma(f, n + BigInt(1), m) else BigInt(0)
  }
}
