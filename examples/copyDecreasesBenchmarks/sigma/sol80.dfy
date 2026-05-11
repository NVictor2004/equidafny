import stainless.collection._
import stainless.lang._
object C_sigma_sol80 {
  def sigma(ftn: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      ftn(a)
    } else {
      ftn(a) + sigma(ftn, a + BigInt(1), b)
    }
  }
}
