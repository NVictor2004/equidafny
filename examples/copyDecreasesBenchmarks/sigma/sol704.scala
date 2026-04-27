import stainless.collection._
import stainless.lang._
object C_sigma_sol704 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def cal(
        sum: BigInt,
        f: BigInt => BigInt,
        now_i: BigInt,
        end_i: BigInt
    ): BigInt = {
      if (now_i > end_i) {
        sum
      } else {
        cal(sum + f(now_i), f, now_i + BigInt(1), end_i)
      }
    }
    cal(BigInt(0), f, a, b)
  }
}
