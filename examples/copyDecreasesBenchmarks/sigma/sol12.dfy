import stainless.collection._
import stainless.lang._
object C_sigma_sol12 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def s(a: BigInt, b: BigInt, f: BigInt => BigInt): BigInt = {
      if (a > b) BigInt(0) else f(a) + s(a + BigInt(1), b, f)
    }
    if (a > b) BigInt(0) else s(a, b, f)
  }
}
