import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol382 {
   
  
  def cal(exp: Exp): Int = {
    exp match {
      case Num(e1) => { e1 }
      case Plus(e1, e2) => {
        
        val a = cal(e1) + cal(e2)
        a
        
      }
      case Minus(e1, e2) => {
        
        val a = cal(e1) - cal(e2)
        a
        
      }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f1) => { if (eval(f1)) false else true }
      case AndAlso(f1, f2) => { if (eval(f1) && eval(f2)) true else false }
      case OrElse(f1, f2) => { if (eval(f1) || eval(f2)) true else false }
      case Imply(f1, f2) => { if (eval(f1) && eval(Not(f2))) false else true }
      case Equal(n1, n2) => { if (cal(n1) == cal(n2)) true else false }
    }
  }
}
