import stainless.collection._
import stainless.lang._
object C_sigma_sol451 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    (a, b) match {
      case (a, b) => {
        if (a > b) {
          BigInt(0)
        } else if (a == b) {
          f(a)
        } else {
          f(a) + sigma(f, a + BigInt(1), b)
        }
      }
    }
  }
}
