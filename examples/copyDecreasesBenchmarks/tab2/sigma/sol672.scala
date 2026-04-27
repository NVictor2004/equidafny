import stainless.collection._
import stainless.lang._
object C_sigma_sol672 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def rsigma(a: BigInt, b: BigInt): BigInt = {
      if (a > b) BigInt(0) else f(a) + rsigma(a + BigInt(1), b)
    }
    rsigma(a, b)
  }
}
