import stainless.collection._
import stainless.lang._
object C_sigma_sol96 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else f(b) + sigma(f, a, b - BigInt(1))
  }
}
