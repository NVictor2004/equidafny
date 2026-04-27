import stainless.collection._
import stainless.lang._
object C_sigma_sol203 {
  def get_first[A, B, C](t: (A, B, C)) = {
    t match {
      case (x, _, _) => { x }
    }
  }
  def get_second[A, B, C](t: (A, B, C)) = {
    t match {
      case (_, x, _) => { x }
    }
  }
  def get_third[A, B, C](t: (A, B, C)) = {
    t match {
      case (_, _, x) => { x }
    }
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      sigma(f, a + BigInt(1), b) + f(a)
    }
  }
}
