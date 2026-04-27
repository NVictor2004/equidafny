import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol402 {
   
  
  def cal(num: Exp): Exp = {
    num match {
      case Num(i) => { Num(i) }
      case Plus(a, b) => {
        (a, b) match {
          case (Num(a2), Num(b2)) => { Num(a2 + b2) }
          case (_, _) => { Plus(cal(a), cal(b)) }
        }
      }
      case Minus(a, b) => {
        (a, b) match {
          case (Num(a2), Num(b2)) => { Num(a2 - b2) }
          case (_, _) => { Minus(cal(a), cal(b)) }
        }
      }
    }
  } 
  
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(x) => { if (eval(x) == true) false else true }
      case AndAlso(x, y) => { eval(x) && eval(y) }
      case OrElse(x, y) => { eval(x) || eval(y) }
      case Imply(x, y) => {
        if (eval(x) == true && eval(y) == false) false else true
      }
      case Equal(x, y) => {
        (x, y) match {
          case (Num(x2), Num(y2)) => { if (x2 == y2) true else false }
          case (_, _) => { eval(Equal(cal(x), cal(y))) }
        }
      }
    }
  }
  
  
  		
  
  
}
