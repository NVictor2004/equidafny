import stainless.collection._
import stainless.lang._
object C_sigma_sol232 {
  def sigma(func: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a - b > BigInt(0)) BigInt(0)
    else func(a) + sigma(func, a + BigInt(1), b)
  }
}
