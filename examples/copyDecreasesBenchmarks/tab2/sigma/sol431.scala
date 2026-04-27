import stainless.collection._
import stainless.lang._
object C_sigma_sol431 {
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    def sigma_0(
        acc: BigInt,
        a: BigInt,
        b: BigInt,
        f: BigInt => BigInt
    ): BigInt = {
      if (a > b) acc else f(a) + sigma_0(acc, a + BigInt(1), b, f)
    }
    if (x > y) BigInt(0) else sigma_0(BigInt(0), x, y, f)
  }
}
