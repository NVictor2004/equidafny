import stainless.collection._
import stainless.lang._
object C_sigma_sol86 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b > a) {
      f(b) + sigma(f, a, b - BigInt(1))
    } else if (b == a) {
      f(b)
    } else {
      BigInt(0)
    }
  }
}
