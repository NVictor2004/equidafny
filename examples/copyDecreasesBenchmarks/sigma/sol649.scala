import stainless.collection._
import stainless.lang._
object C_sigma_sol649 {
  def sigma(tmp: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else tmp(a) + sigma(tmp, a + BigInt(1), b)
  }
}
