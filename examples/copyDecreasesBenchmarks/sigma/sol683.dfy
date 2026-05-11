import stainless.collection._
import stainless.lang._
object C_sigma_sol683 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else {
      def loop(a: BigInt, r: BigInt): BigInt = {
        if (a > b) BigInt(0)
        else if (a == b) r + f(a) 
        else loop(a + BigInt(1), r + f(a))
      }
      loop(a, BigInt(0))
    }
  }
}
