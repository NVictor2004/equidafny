import stainless.collection._
import stainless.lang._
object C_sigma_sol651 {
  def sigma(test: BigInt => BigInt, first: BigInt, second: BigInt): BigInt = {
    if (first > second) {
      BigInt(0)
    } else {
      test(first) + sigma(test, first + BigInt(1), second)
    }
  }
}
