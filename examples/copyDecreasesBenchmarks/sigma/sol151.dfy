import stainless.collection._
import stainless.lang._
object C_sigma_sol151 {
  def sigma(f: BigInt => BigInt, st: BigInt, ed: BigInt): BigInt = {
    if (st > ed) {
      BigInt(0)
    } else if (st == ed) {
      f(st)
    } else {
      f(st) + sigma(f, st + BigInt(1), ed)
    }
  }
}
