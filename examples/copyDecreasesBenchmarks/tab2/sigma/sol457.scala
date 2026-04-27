import stainless.collection._
import stainless.lang._
object C_sigma_sol457 {
  def sigma(func: BigInt => BigInt, min: BigInt, max: BigInt): BigInt = {
    if (min > max) {
      BigInt(0)
    } else if (min == max) {
      func(min)
    } else {
      func(min) + sigma(func, min + BigInt(1), max)
    }
  }
}
