import stainless.collection._
import stainless.lang._
object ta_solutions_sigma {
  def solution_1(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    decreases(if (b == a) BigInt(2) else if (b > a) 2 + b - a else a - b)
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(a) + solution_1(f, a + BigInt(1), b)
    }
  }
  def solution_2(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    decreases(if (b == a) BigInt(2) else if (b > a) 2 + b - a else a - b)
    if (a > b) {
      BigInt(0)
    } else if (a == b) {
      f(a)
    } else {
      f(b) + solution_2(f, a, b - BigInt(1))
    }
  }
  def solution_3(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def s(a: BigInt, b: BigInt, f: BigInt => BigInt, acc: BigInt): BigInt = {
      decreases(if (b == a) BigInt(2) else if (b > a) 2 + b - a else a - b)
      if (a > b) acc else s(a + BigInt(1), b, f, acc + f(a))
    }
    s(a, b, f, BigInt(0))
  }
}
