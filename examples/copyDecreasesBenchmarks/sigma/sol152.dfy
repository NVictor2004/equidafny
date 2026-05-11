import stainless.collection._
import stainless.lang._
object C_sigma_sol152 {
  def sigma(n: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a <= b) {
      def sum(a: BigInt, b: BigInt, n: BigInt => BigInt): BigInt = {
        if (a > b) BigInt(0)
        else if (a == b) n(a) 
        else n(a) + sum(a + BigInt(1), b, n)
      }
      sum(a, b, n)
    } else {
      BigInt(0)
    }
  }
}
