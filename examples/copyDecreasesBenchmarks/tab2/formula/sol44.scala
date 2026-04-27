import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol44 {
  
  
  
  def eval(form: Formula): Boolean = {
    def getValue(exp: Exp): Int = {
      exp match {
        case Num(n) => { n }
        case Plus(a, b) => { getValue(a) + getValue(b) }
        case Minus(a, b) => { getValue(a) - getValue(b) }
      }
    }
    form match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => { if (eval(a)) false else true }
      case AndAlso(a, b) => { eval(a) && eval(b) }
      case OrElse(a, b) => { eval(a) || eval(b) }
      case Imply(a, b) => { if (eval(a) && eval(Not(b))) false else true }
      case Equal(a, b) => { if (getValue(a) == getValue(b)) true else false }
      case _ => { true }
    }
    
  }
  	
  		
}