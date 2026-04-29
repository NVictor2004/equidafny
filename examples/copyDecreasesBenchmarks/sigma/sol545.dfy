import stainless.collection._
import stainless.lang._
object C_sigma_sol545 {
  sealed case class Invalid_position() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(a) + sigma(f, a + BigInt(1), b)
    }
  }
}
