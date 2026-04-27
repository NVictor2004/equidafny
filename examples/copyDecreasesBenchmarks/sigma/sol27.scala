import stainless.collection._
import stainless.lang._
object C_sigma_sol27 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(a) + sigma(f, a + BigInt(1), b)
    }
  }
  def f1(n: BigInt) = { n }
  def f2(n: BigInt) = { n * n }
}
