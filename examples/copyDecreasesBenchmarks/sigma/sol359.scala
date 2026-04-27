import stainless.collection._
import stainless.lang._
object C_sigma_sol359 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def aux(
        a: BigInt,
        b: BigInt,
        f: BigInt => BigInt,
        result: BigInt
    ): BigInt = {
      if (a > b) result else aux(a + BigInt(1), b, f, result + f(a))
    }
    aux(a, b, f, BigInt(0))
  }
}
