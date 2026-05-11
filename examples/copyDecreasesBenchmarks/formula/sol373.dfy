import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol373 {
   
  
  def exp_to_int(e: Exp): Int = {
    e match {
      case Num(n) => { n }
      case Plus(e1, e2) => { exp_to_int(e1) + exp_to_int(e2) }
      case Minus(e1, e2) => { exp_to_int(e1) - exp_to_int(e2) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f1) => { if (eval(f1)) false else true }
      case AndAlso(f1, f2) => { if (eval(f1)) eval(f2) else false }
      case OrElse(f1, f2) => { if (eval(f1)) true else eval(f2) }
      case Imply(f1, f2) => { eval(OrElse(Not(f1), f2)) }
      case Equal(e1, e2) => { exp_to_int(e1) == exp_to_int(e2) }
    }
  }
}