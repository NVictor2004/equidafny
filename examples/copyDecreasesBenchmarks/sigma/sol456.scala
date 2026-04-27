import stainless.collection._
import stainless.lang._
object C_sigma_sol456 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b < a) BigInt(0) else f(b) + sigma(f, a, b - BigInt(1))
  }
}
