import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol511 {
  
  
  def eval(f: Formula): Boolean = {
    def exp_int(g: Exp): Int = {
      g match {
        case Num(x) => { x }
        case Plus(x, y) => { exp_int(x) + exp_int(y) }
        case Minus(x, y) => { exp_int(x) - exp_int(y) }
      }
    }
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(x) => { if (eval(x)) false else true }
      case AndAlso(x, y) => { if (eval(x) && eval(y)) true else false }
      case OrElse(x, y) => { if (eval(x) || eval(y)) true else false }
      case Imply(x, y) => { if (eval(x) && eval(Not(y))) false else true }
      case Equal(a, b) => { exp_int(a) == exp_int(b) }
    }
    
  }
}