import stainless.collection._
import stainless.lang._
object C_sigma_sol377 {
  def sigma_0(
      a: BigInt,
      b: BigInt,
      f: BigInt => BigInt,
      subSum: BigInt
  ): BigInt = {
    if (a > b) BigInt(0) 
    else if (a == b) f(a) + subSum 
    else sigma_0(a + BigInt(1), b, f, subSum + f(a))
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else sigma_0(a, b, f, BigInt(0))
  }
}
