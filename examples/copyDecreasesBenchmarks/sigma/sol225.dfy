import stainless.collection._
import stainless.lang._
object C_sigma_sol225 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else {
      def aux(c: BigInt, d: BigInt): BigInt = {
        if (c >= b) d else aux(c + BigInt(1), d + f(c + BigInt(1)))
      }
      aux(a, f(a))
    }
  }
}
