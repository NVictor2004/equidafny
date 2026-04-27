import stainless.collection._
import stainless.lang._
object C_sigma_sol699 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b <= a - BigInt(1)) BigInt(0) else sigma(f, a, b - BigInt(1)) + f(b)
  }
}
