import stainless.collection._
import stainless.lang._
object C_sigma_sol380 {
  def sum_list(fn: BigInt => BigInt, x: List[BigInt]): BigInt = {
    x match {
      case Nil()        => { BigInt(0) }
      case Cons(hd, tl) => { fn(hd) + sum_list(fn, tl) }
    }
  }
  def make_list(a: BigInt, b: BigInt): List[BigInt] = {
    if (a <= b) a :: make_list(a + BigInt(1), b) else Nil()
  }
  def sigma(fn: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    sum_list(fn, make_list(a, b))
  }
}
