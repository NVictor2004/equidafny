import stainless.lang._

object term {
  sealed trait Term
  case class Val(v: Int) extends Term
  case class UMinus(t: Term) extends Term
  case class Mult(left: Term, right: Term) extends Term
  
  def eval(t: Term): Int = {
      t match {
          case Val(v) => v
          case UMinus(t) => -eval(t)
          case Mult(left, right) => eval(left) * eval(right)
      }
  }
  
  def rip(t: Term): Term = {
      t match {
          case Val(v) => Val(v)
          case UMinus(t) => rip(t)
          case Mult(left, right) => Mult(rip(left), rip(right))
      }
  }
  
  def pos(t: Term): Boolean = {
      t match {
          case Val(v) => true
          case UMinus(t) => !pos(t)
          case Mult(left, right) => pos(left) == pos(right)
      }
  }
  
  def wSign(i: Int, b: Boolean): Int = {
      if b then i else -i
  }
  
  def evalM(t: Term): Int = {
      eval(t)
  }
  
  def eval1(t: Term): Int = {
      wSign(eval(rip(t)), pos(t)) 
  }
}
