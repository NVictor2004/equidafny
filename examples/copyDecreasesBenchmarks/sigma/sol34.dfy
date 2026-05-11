import stainless.collection._
import stainless.lang._
object C_sigma_sol34 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    a - b match {
      case i if i == BigInt(0) => { f(a) }
      case _ => {
        if (a > b) {
          BigInt(0)
        } else {
          f(a) + sigma(f, a + BigInt(1), b)
        }
      }
    }
  }
}
