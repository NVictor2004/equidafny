import stainless.collection._
import stainless.lang._
object C_sigma_sol165 {
  sealed case class NUMBERERROR() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a == b) {
      f(a)
    } else if (a > b) {
      BigInt(0)
    } else {
      sigma(f, a + BigInt(1), b) + f(a)
    }
  }
}
