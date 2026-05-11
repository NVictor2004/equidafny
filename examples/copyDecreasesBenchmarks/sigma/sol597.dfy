import stainless.collection._
import stainless.lang._
object C_sigma_sol597 {
  def sigma(f: BigInt => BigInt, n1: BigInt, n2: BigInt): BigInt = {
    if (n1 <= n2) f(n1) + sigma(f, n1 + BigInt(1), n2) else BigInt(0)
  }
}
