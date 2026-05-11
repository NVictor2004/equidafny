import stainless.collection._
import stainless.lang._
object C_sigma_sol375 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sigma_rec(n: BigInt, ret: BigInt): BigInt = {
      if (n <= b) sigma_rec(n + BigInt(1), ret + f(n)) else ret
    }
    sigma_rec(a, BigInt(0))
  }
}
