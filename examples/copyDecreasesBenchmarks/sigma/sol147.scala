import stainless.collection._
import stainless.lang._
object C_sigma_sol147 {
  def sigma(f: BigInt => BigInt, s: BigInt, e: BigInt): BigInt = {
    if (s > e) {
      BigInt(0)
    } else if (s == e) {
      f(s)
    } else {
      f(s) + sigma(f, s + BigInt(1), e)
    }
  }
}
