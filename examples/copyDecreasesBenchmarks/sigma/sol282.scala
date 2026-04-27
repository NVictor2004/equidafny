import stainless.collection._
import stainless.lang._
object C_sigma_sol282 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (b > a) {
      sigma(f, a, b - BigInt(1)) + f(b)
    } else if (b < a) {
      BigInt(0)
    } else {
      f(a)
    }
  }
}
