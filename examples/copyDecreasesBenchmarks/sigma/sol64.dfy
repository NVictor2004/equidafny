import stainless.collection._
import stainless.lang._
object C_sigma_sol64 {
  def sigma(f: BigInt => BigInt, cur: BigInt, last: BigInt): BigInt = {
    def inner(cur: BigInt, last: BigInt, f: BigInt => BigInt): BigInt = {
      if (cur > last) BigInt(0) else f(cur) + inner(cur + BigInt(1), last, f)
    }
    if (cur > last) BigInt(0) else inner(cur, last, f)
  }
}
