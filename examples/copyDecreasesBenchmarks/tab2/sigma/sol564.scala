import stainless.collection._
import stainless.lang._
object C_sigma_sol564 {
  def sigma(test: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else test(a) + sigma(test, a + BigInt(1), b)
  }
}
