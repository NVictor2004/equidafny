import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol390 {
   
  
  def sub_fun(e: Exp): Int = {
    e match {
      case Num(i) => { i }
      case Plus(e1, e2) => { sub_fun(e1) + sub_fun(e2) }
      case Minus(e1, e2) => { sub_fun(e1) - sub_fun(e2) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => { if (eval(a)) false else true }
      case AndAlso(a1, a2) => { if (eval(a1) && eval(a2)) true else false }
      case OrElse(a1, a2) => { if (eval(a1) || eval(a2)) true else false }
      case Imply(a1, a2) => { if (eval(a1) && eval(Not(a2))) false else true }
      case Equal(e1, e2) => { if (sub_fun(e1) == sub_fun(e2)) true else false }
    }
  }
  
}
