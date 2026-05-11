import stainless.collection._
import stainless.lang._
object C_sigma_sol220 {
  def sigma(f: BigInt => BigInt, i: BigInt, n: BigInt): BigInt = {
    if (i > n) BigInt(0) else f(i) + sigma(f, i + BigInt(1), n)
  }
}
