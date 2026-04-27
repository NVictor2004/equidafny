import stainless.collection._
import stainless.lang._
object C_sigma_sol187 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def aux(cur: BigInt, acc: BigInt): BigInt = {
      if (cur > b) acc else aux(cur + BigInt(1), acc + f(cur))
    }
    aux(a, BigInt(0))
  }
}
