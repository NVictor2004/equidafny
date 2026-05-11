import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol547 {
   
  
  def cal(f: Exp): Int = {
    f match {
      case Num(n) => { n }
      case Plus(e1, e2) => { cal(e1) + cal(e2) }
      case Minus(e1, e2) => { cal(e1) - cal(e2) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f1) => { if (eval(f1)) false else true }
      case AndAlso(f1, f2) => { if (eval(f1) && eval(f2)) true else false }
      case OrElse(f1, f2) => {
        if (eval(Not(f1)) && eval(Not(f2))) false else true
      }
      case Imply(f1, f2) => {
        
          if (
            eval(Not(f1))
          ) {
            true 
          } else if (
            eval(f1) && eval(f2)
          ) {
            true 
          } else {
            false
          }
      }
      case Equal(e1, e2) => { if (cal(e1) == cal(e2)) true else false }
    }
  }
}