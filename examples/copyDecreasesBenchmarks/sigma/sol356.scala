import stainless.collection._
import stainless.lang._
object C_sigma_sol356 {
  def iter_f(
      a: BigInt,
      b: BigInt,
      f: BigInt => BigInt,
      result: BigInt
  ): BigInt = {
    if (a <= b) iter_f(a + BigInt(1), b, f, result + f(a)) else result
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    iter_f(a, b, f, BigInt(0))
  }
}
