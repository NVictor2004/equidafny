import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol204 {
  
  
  def eval(form: Formula): Boolean = {
    form match {
      case True_ => { true }
      case False_ => { false }
      case Not(first) => { if (eval(first)) false else true }
      case AndAlso(first, second) => { eval(first) && eval(second) }
      case OrElse(first, second) => { eval(first) || eval(second) }
      case Imply(first, second) => { eval(OrElse(Not(first), second)) }
      case Equal(first, second) => {
        
        def eval2(exp: Exp): Int = {
          exp match {
            case Num(val1) => { val1 }
            case Plus(val1, val2) => { eval2(val1) + eval2(val2) }
            case Minus(val1, val2) => { eval2(val1) - eval2(val2) }
          }
        }
        eval2(first) == eval2(second)
        
      }
    }
  }
  
}
