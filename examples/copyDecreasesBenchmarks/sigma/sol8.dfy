import stainless.collection._
import stainless.lang._
object C_sigma_sol8 {
  sealed case class Error(param0: String) extends Exception {}
  def adder(a: BigInt, b: BigInt): BigInt = { a + b }
  def sigma(f: BigInt => BigInt, x: BigInt, y: BigInt): BigInt = {
    def sum(l: List[BigInt]): BigInt = l.foldLeft(BigInt(0))(adder)
    def range(a: BigInt, b: BigInt): List[BigInt] = {
      if (a > b) Nil() else a :: range(a + BigInt(1), b)
    }
    if (x > y) BigInt(0) else sum(range(x, y).map(f))
  }
}
