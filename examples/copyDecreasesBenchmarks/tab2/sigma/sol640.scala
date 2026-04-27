import stainless.collection._
import stainless.lang._
object C_sigma_sol640 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def sum(
        now_sum: BigInt,
        f: BigInt => BigInt,
        now_i: BigInt,
        end_i: BigInt
    ): BigInt = {
      now_i > end_i match {
        case true  => { now_sum }
        case false => { sum(now_sum + f(now_i), f, now_i + BigInt(1), end_i) }
      }
    }
    sum(BigInt(0), f, a, b)
  }
}
