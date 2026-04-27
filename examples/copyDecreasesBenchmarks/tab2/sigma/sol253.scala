import stainless.collection._
import stainless.lang._
object C_sigma_sol253 {
  def sigma(func: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma_r(c: BigInt, d: BigInt, result: BigInt): BigInt = {
      if (c <= d) sigma_r(c + BigInt(1), d, result + func(c)) else result
    }
    sigma_r(a, b, BigInt(0))
  }
}
