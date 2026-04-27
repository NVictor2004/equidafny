import stainless.collection._
import stainless.lang._
object C_sigma_sol72 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma2(
        a: BigInt,
        b: BigInt,
        f: BigInt => BigInt,
        sum: BigInt
    ): BigInt = {
      if (a > b) BigInt(0)
      else if (a == b) sum + f(a) 
      else sigma2(a + BigInt(1), b, f, sum + f(a))
    }
    if (a > b) BigInt(0) else sigma2(a, b, f, BigInt(0))
  }
}
