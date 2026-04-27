import stainless.collection._
import stainless.lang._
object C_sigma_sol40 {
  def sigma(f: BigInt => BigInt, i_start: BigInt, i_end: BigInt): BigInt = {
    if (i_start > i_end) BigInt(0)
    else if (i_start == i_end) {
      f(i_start)
    } else {
      f(i_start) + sigma(f, i_start + BigInt(1), i_end)
    }
  }
}
