import stainless.collection._
import stainless.lang._
object C_sigma_sol620 {
  sealed case class Problem() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b >= a) f(a) + sigma(f, a + BigInt(1), b) else BigInt(0)
  }
}
