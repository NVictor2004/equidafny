import stainless.collection._
import stainless.lang._
object C_sigma_sol383 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma2(
        a: BigInt,
        b: BigInt,
        f: BigInt => BigInt,
        sum: BigInt
    ): BigInt = {
      if (a > b) sum else sigma2(a + BigInt(1), b, f, sum + f(a))
    }
    sigma2(a, b, f, BigInt(0))
  }
}
