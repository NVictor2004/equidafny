import stainless.collection._
import stainless.lang._
object C_sigma_sol573 {
  def map(f: BigInt => BigInt, l: List[BigInt]): List[BigInt] = {
    l match {
      case Nil()            => { Nil() }
      case Cons(head, tail) => { f(head) :: map(f, tail) }
    }
  }
  def fold(
      f: (BigInt, BigInt) => BigInt,
      l: List[BigInt],
      acc: BigInt
  ): BigInt = {
    l match {
      case Nil()            => { acc }
      case Cons(head, tail) => { f(head, fold(f, tail, acc)) }
    }
  }
  def helper(start: BigInt, halt: BigInt): List[BigInt] = {
    def aux(n: BigInt, acc: List[BigInt]): List[BigInt] = {
      if (n < start) acc else aux(n - BigInt(1), n :: acc)
    }
    aux(halt, Nil())
  }
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    fold(
      {
        case (x, y) => { x + y }
      },
      map(f, helper(a, b)),
      BigInt(0)
    )
  }
}
