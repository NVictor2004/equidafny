import stainless.collection._
import stainless.lang._
object C_sigma_sol558 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else if (a < b) sigma(f, a + BigInt(1), b) + f(a) else f(a)
  }
}
