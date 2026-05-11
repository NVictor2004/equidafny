import stainless.collection._
import stainless.lang._
object C_sigma_sol419 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sum(i: BigInt, total: BigInt): BigInt = {
      if (i > b) total else sum(i + BigInt(1), total + f(i))
    }
    sum(a, BigInt(0))
  }
}
