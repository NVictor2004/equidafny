import stainless.collection._
import stainless.lang._
object C_sigma_sol109 {
  def sigma(func: BigInt => BigInt, int1: BigInt, int2: BigInt): BigInt = {
    if (int1 > int2) {
      BigInt(0)
    } else if (int1 == int2) {
      func(int1)
    } else {
      func(int1) + sigma(func, int1 + BigInt(1), int2)
    }
  }
}
