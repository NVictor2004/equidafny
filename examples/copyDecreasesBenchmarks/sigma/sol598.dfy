import stainless.collection._
import stainless.lang._
object C_sigma_sol598 {
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (y < x) {
      BigInt(0)
    } else if (x == y) {
      f(x)
    } else {
      f(y) + sigma(f, x, y - BigInt(1))
    }
  }
}
