import stainless.collection._
import stainless.lang._
object C_sigma_sol410 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    (a, b) match {
      case (x, y) => {
        if (x == y) {
          f(x)
        } else if (x > y) {
          BigInt(0)
        } else {
          f(x) + sigma(f, x + BigInt(1), y)
        }
      }
    }
  }
}
