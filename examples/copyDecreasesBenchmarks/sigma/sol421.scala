import stainless.collection._
import stainless.lang._
object C_sigma_sol421 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sum(x: BigInt, s: BigInt): BigInt = {
      if (x > b) s else sum(x + BigInt(1), s + f(x))
    }
    sum(a, BigInt(0))
  }
}
