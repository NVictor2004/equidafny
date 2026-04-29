import stainless.collection._
import stainless.lang._
object C_sigma_sol647 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a < b) {
      f(b) + sigma(f, a, b - BigInt(1))
    } else if (a == b) {
      f(a)
    } else {
      BigInt(0)
    }
  }
}
