import stainless.collection._
import stainless.lang._
object C_sigma_sol221 {
  def sigma(func: BigInt => BigInt, start: BigInt, finish: BigInt): BigInt = {
    if (start > finish) {
      BigInt(0)
    } else {
      func(start) + sigma(func, start + BigInt(1), finish)
    }
  }
}
