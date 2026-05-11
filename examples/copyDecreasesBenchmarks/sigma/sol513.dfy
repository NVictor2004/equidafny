import stainless.collection._
import stainless.lang._
object C_sigma_sol513 {
  def sigma(f: BigInt => BigInt, int1: BigInt, int2: BigInt): BigInt = {
    if (int1 == int2) {
      f(int2)
    } else if (int2 > int1) {
      sigma(f, int1 + BigInt(1), int2) + f(int1)
    } else {
      BigInt(0)
    }
  }
}
