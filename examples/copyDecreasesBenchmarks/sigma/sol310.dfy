import stainless.collection._
import stainless.lang._
object C_sigma_sol310 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a == b) {
      f(a)
    } else if (a > b) {
      BigInt(0)
    } else {
      sigma(f, a, b - BigInt(1)) + sigma(f, b, b)
    }
  }
}
