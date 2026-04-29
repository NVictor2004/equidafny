import stainless.collection._
import stainless.lang._
object C_sigma_sol223 {
  val sum = BigInt(0)
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) sum else sum + f(a) + sigma(f, a + BigInt(1), b)
  }
}
