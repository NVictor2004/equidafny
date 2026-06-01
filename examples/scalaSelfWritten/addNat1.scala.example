import stainless.lang._

object addNat1 {
  
  sealed trait Nat
  case object Zero extends Nat
  case class Succ(n: Nat) extends Nat
  
  def addHelper(n: Nat, m: Nat): Nat = {
      n match {
          case Zero => m
          case Succ(n) => Succ(addHelper(n, m))
      }
  }
  
  def addM(n: Nat, m: Nat): Nat = {
      addHelper(n, m)
  }
  
  def add1(n: Nat, m: Nat): Nat = {
      addHelper(m, n)
  }
}
