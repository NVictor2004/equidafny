import stainless.collection._
import stainless.lang._
object C_sigma_sol173 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0) else sigma(f, a + BigInt(1), b) + f(a)
  }
  def test_func(a: BigInt) = { a * BigInt(2) }
}
