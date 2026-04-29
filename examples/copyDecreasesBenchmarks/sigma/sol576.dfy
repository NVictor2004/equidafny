import stainless.collection._
import stainless.lang._
object C_sigma_sol576 {
  def sigma(test: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x <= y) test(x) + sigma(test, x + BigInt(1), y) else BigInt(0)
  }
}
