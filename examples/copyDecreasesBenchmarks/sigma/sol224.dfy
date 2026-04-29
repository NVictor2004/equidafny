import stainless.collection._
import stainless.lang._
object C_sigma_sol224 {
  def sigma(f: BigInt => BigInt, fromIndex: BigInt, toIndex: BigInt): BigInt = {
    def sigma_aux(currentIndex: BigInt, result: BigInt): BigInt = {
      if (currentIndex > toIndex) {
        result
      } else {
        sigma_aux(currentIndex + BigInt(1), result + f(currentIndex))
      }
    }
    sigma_aux(fromIndex, BigInt(0))
  }
}
