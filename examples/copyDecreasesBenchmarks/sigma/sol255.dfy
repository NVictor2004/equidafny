import stainless.collection._
import stainless.lang._
object C_sigma_sol255 {
  def get_first[A, B, C](some_tuple: (A, B, C)) = {
    some_tuple match {
      case (x, _, _) => { x }
    }
  }
  def get_second[A, B, C](some_tuple: (A, B, C)) = {
    some_tuple match {
      case (_, x, _) => { x }
    }
  }
  def get_third[A, B, C](some_tuple: (A, B, C)) = {
    some_tuple match {
      case (_, _, x) => { x }
    }
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(a) + sigma(f, a + BigInt(1), b)
    }
  }
}
