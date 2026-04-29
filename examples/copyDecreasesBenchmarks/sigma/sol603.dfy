import stainless.collection._
import stainless.lang._
object C_sigma_sol603 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else if (b > a) sigma(f, a, b - BigInt(1)) + f(b) else f(a)
  }
}
