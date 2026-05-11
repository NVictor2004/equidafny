import stainless.collection._
import stainless.lang._
object C_sigma_sol519 {
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x > y) BigInt(0) else if (x < y) f(x) + sigma(f, x + BigInt(1), y) else f(x)
  }
}
