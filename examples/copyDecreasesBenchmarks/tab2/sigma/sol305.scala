import stainless.collection._
import stainless.lang._
object C_sigma_sol305 {
  def sigma(ft: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else ft(a) + sigma(ft, a + BigInt(1), b)
  }
}
