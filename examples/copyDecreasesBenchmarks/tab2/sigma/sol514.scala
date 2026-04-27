import stainless.collection._
import stainless.lang._
object C_sigma_sol514 {
  def sigma(fnt: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else fnt(a) + sigma(fnt, a + BigInt(1), b)
  }
}
