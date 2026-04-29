import stainless.collection._
import stainless.lang._
object C_sigma_sol521 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a <= b) f(a) + sigma(f, a + BigInt(1), b) else BigInt(0)
  }
}
