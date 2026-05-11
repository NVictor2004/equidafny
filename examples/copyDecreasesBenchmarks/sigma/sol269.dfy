import stainless.collection._
import stainless.lang._
object C_sigma_sol269 {
  def func(n: BigInt) = { n + BigInt(1) }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a == b) {
      f(a)
    } else if (a > b) {
      BigInt(0)
    } else {
      f(b) + sigma(f, a, b - BigInt(1))
    }
  }
}
