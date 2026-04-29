import stainless.collection._
import stainless.lang._
object C_sigma_sol501 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else {
      (a, b, f) match {
        case (a, b, f) => {
          if (a == b) f(a) else f(a) + sigma(f, a + BigInt(1), b)
        }
      }
    }
  }
}
