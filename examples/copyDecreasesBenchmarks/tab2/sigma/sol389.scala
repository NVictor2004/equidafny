import stainless.collection._
import stainless.lang._
object C_sigma_sol389 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a <= b) f(b) + sigma(f, a, b - BigInt(1)) else BigInt(0)
  }
}
