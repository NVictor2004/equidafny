import stainless.collection._
import stainless.lang._
object C_sigma_sol265 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigmaInternal(n: BigInt, result: BigInt): BigInt = {
      if (n > b) result else sigmaInternal(n + BigInt(1), result + f(n))
    }
    sigmaInternal(a, BigInt(0))
  }
}
