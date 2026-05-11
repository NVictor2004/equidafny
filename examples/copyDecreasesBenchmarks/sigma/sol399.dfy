import stainless.collection._
import stainless.lang._
object C_sigma_sol399 {
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x > y) BigInt(0) else f(y) + sigma(f, x, y - BigInt(1))
  }
}
