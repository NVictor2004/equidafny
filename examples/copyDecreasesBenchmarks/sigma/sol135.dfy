import stainless.collection._
import stainless.lang._
object C_sigma_sol135 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    (a, b, f) match {
      case (a, b, f) => {
        if (a > b) BigInt(0) else f(a) + sigma(f, a + BigInt(1), b)
      }
    }
  }
}
