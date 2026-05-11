import stainless.collection._
import stainless.lang._
object C_sigma_sol236 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def cal(a: BigInt, b: BigInt, f: BigInt => BigInt, rs: BigInt): BigInt = {
      if (a > b) rs else cal(a + BigInt(1), b, f, rs + f(a))
    }
    if (a > b) BigInt(0) else cal(a, b, f, BigInt(0))
  }
}
