import stainless.collection._
import stainless.lang._
object C_sigma_sol361 {
  def sigma(f_n: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a == b) {
      f_n(a)
    } else if (a > b) {
      BigInt(0)
    } else {
      f_n(a) + sigma(f_n, a + BigInt(1), b)
    }
  }
}
