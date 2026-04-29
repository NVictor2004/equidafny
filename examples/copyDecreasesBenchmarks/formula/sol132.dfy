import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol132 {
  
  
  def eval(fmla: Formula): Boolean = {
    def calexp(exp: Exp): Int = {
      exp match {
        case Num(a) => { a }
        case Plus(a, b) => { calexp(a) + calexp(b) }
        case Minus(a, b) => { calexp(a) - calexp(b) }
      }
    }
    fmla match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => { !eval(a) }
      case AndAlso(a, b) => { eval(a) && eval(b) }
      case OrElse(a, b) => { eval(a) || eval(b) }
      case Imply(a, b) => { if (eval(a)) eval(b) else eval(True_) }
      case Equal(a, b) => { calexp(a) == calexp(b) }
    }
    
  }
}
