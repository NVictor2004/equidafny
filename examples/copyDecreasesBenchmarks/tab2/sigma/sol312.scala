import stainless.collection._
import stainless.lang._
object C_sigma_sol312 {
  def sigma(funx: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else funx(a) + sigma(funx, a + BigInt(1), b)
  }
}
