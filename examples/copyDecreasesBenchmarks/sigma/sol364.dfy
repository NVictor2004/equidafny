import stainless.collection._
import stainless.lang._
object C_sigma_sol364 {
  def sigma_0(a: BigInt, b: BigInt, f: BigInt => BigInt): BigInt = {
    if (b < a) BigInt(0) else f(a) + sigma_0(a + BigInt(1), b, f)
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    sigma_0(a, b, f)
  }
}
