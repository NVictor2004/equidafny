import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol581 {
  
  
                    
  def c2N(exp: Exp): Int = {
    exp match {
      case Num(n_0) => { n_0 }
      case Plus(x_0, y_0) => { c2N(x_0) + c2N(y_0) }
      case Minus(x_0, y_0) => { c2N(x_0) - c2N(y_0) }
    }
  }
        
  def reverse(x: Boolean): Formula = { if (x == true) False_ else True_ }
    
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(a_0) => { eval(reverse(eval(a_0))) }
      case Equal(a_0, b_0) => { if (c2N(a_0) == c2N(b_0)) true else false }
      case Imply(a_0, b_0) => {
        if (eval(a_0) == true && eval(b_0) == false) false else true
      }
      case AndAlso(a_0, b_0) => { eval(a_0) && eval(b_0) }
      case OrElse(a_0, b_0) => { eval(a_0) || eval(b_0) }
    }
  }
      
  /* eval(Equal(Plus(Num(1), Num(1)), Minus(Num(4), Num(2)))) */
  /* eval(Imply(Imply(True_, False_), True_)) */
}