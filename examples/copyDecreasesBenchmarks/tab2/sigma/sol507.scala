import stainless.collection._
import stainless.lang._
object C_sigma_sol507 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def aux(a: BigInt, b: BigInt, f: BigInt => BigInt, acc: BigInt): BigInt = {
      if (a > b) acc else aux(a + BigInt(1), b, f, acc + f(a))
    }
    aux(a, b, f, BigInt(0))
  }
}
