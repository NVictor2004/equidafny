import stainless.collection._
import stainless.lang._
object C_sigma_sol131 {
  def sigma(f: BigInt => BigInt, i1: BigInt, i2: BigInt): BigInt = {
    if (i1 > i2) {
      BigInt(0)
    } else if (i1 == i2) {
      f(i1)
    } else {
      f(i1) + sigma(f, i1 + BigInt(1), i2)
    }
  }
}
