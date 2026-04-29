import stainless.collection._
import stainless.lang._
object C_sigma_sol235 {
  def sigma(fn: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else fn(a) + sigma(fn, a + BigInt(1), b)
  }
}
