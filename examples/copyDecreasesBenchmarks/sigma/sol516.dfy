import stainless.collection._
import stainless.lang._
object C_sigma_sol516 {
  sealed case class WrongInput() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else {
      b - a match {
        case i if i == BigInt(0) => { f(a) }
        case _         => { sigma(f, a + BigInt(1), b) + f(a) }
      }
    }
  }
}
