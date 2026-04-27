import stainless.collection._
import stainless.lang._
object C_sigma_sol19 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else f(a) + sigma(f, a + BigInt(1), b)
  }
}
