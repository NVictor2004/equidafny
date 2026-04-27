import stainless.collection._
import stainless.lang._
object C_sigma_sol473 {
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x > y) BigInt(0) else f(x) + sigma(f, x + BigInt(1), y)
  }
}
