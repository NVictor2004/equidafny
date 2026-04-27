import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol479 {
  
  
  def cal(ex: Exp): Int = {
    ex match {
      case Num(i) => { i }
      case Plus(ex1, ex2) => { cal(ex1) + cal(ex2) }
      case Minus(ex1, ex2) => { cal(ex1) - cal(ex2) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f_not) => { if (eval(f_not) == true) false else true }
      case AndAlso(f1, f2) => { eval(f1) && eval(f2) }
      case OrElse(f1, f2) => { eval(f1) || eval(f2) }
      case Imply(f1, f2) => { eval(Not(f1)) || eval(f2) }
      case Equal(ex1, ex2) => { if (cal(ex1) == cal(ex2)) true else false }
    }
  } 
}