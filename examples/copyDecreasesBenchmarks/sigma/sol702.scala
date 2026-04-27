import stainless.collection._
import stainless.lang._
object C_sigma_sol702 {
  def is_enough(x: BigInt, y: BigInt): Boolean = { if (x > y) true else false }
  def sum(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    val x1: BigInt = f(x)
    x1 + y
  }
  def sigmaloop(
      f: BigInt => BigInt,
      x: BigInt,
      y: BigInt,
      z: BigInt
  ): BigInt = {
    if (is_enough(x, y)) z else sigmaloop(f, x + BigInt(1), y, sum(f, x, z))
  }
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    if (x > y) BigInt(0) else sigmaloop(f, x, y, BigInt(0))
  }
}
