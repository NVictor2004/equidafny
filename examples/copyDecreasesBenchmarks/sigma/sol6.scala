import stainless.collection._
import stainless.lang._
import stainless.collection._
object C_sigma_sol6 {
  sealed case class Error(param0: String) extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def gen(a: BigInt, b: BigInt): List[BigInt] = {
      if (a > b) {
        choose((x: List[BigInt]) => true)
      } else if (a == b) {
        List(a)
      } else {
        a :: gen(a + BigInt(1), b)
      }
    }
    def fsum(f: BigInt => BigInt, l: List[BigInt], sum: BigInt): BigInt = {
      l match {
        case Nil()      => { sum }
        case Cons(h, t) => { fsum(f, t, sum) + f(h) }
      }
    }
    if (a > b) BigInt(0) else fsum(f, gen(a, b), BigInt(0))
  }
}
