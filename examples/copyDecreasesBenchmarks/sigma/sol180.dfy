import stainless.collection._
import stainless.lang._
object C_sigma_sol180 {
  def sigma(k: BigInt => BigInt, i: BigInt, j: BigInt): BigInt = {
    (i, j, k) match {
      case (p, q, f) => {
        if (p == q) {
          f(p)
        } else if (p > q) {
          BigInt(0)
        } else {
          f(p) + sigma(f, p + BigInt(1), q)
        }
      }
    }
  }
}
