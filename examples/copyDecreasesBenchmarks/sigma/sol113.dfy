import stainless.collection._
import stainless.lang._
object C_sigma_sol113 {
  sealed case class NOMOVE(param0: String) extends Exception {}
  def sigma(func: BigInt => BigInt, init: BigInt, uppr: BigInt): BigInt = {
    if (init < uppr) {
      func(init) + sigma(func, init + BigInt(1), uppr)
    } else if (init == uppr) {
      func(init)
    } else {
      BigInt(0)
    }
  }
}
