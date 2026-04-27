import stainless.collection._
import stainless.lang._
object C_sigma_sol378 {
  def sigma(fn: BigInt => BigInt, i1: BigInt, i2: BigInt): BigInt = {
    if (i1 > i2) BigInt(0) else fn(i1) + sigma(fn, i1 + BigInt(1), i2)
  }
}
