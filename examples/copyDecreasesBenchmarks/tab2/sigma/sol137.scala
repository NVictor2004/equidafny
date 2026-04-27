import stainless.collection._
import stainless.lang._
object C_sigma_sol137 {
  def sigma(func: BigInt => BigInt, lower: BigInt, upper: BigInt): BigInt = {
    if (lower <= upper) {
      if (lower == upper) {
        func(lower)
      } else {
        func(lower) + sigma(func, lower + BigInt(1), upper)
      }
    } else {
      BigInt(0)
    }
  }
}
