import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol371 {
   
  
  def evalExp(x: Exp): Int = {
    x match {
      case Num(a) => { a }
      case Plus(a, b) => { evalExp(a) + evalExp(b) }
      case Minus(a, b) => { evalExp(a) - evalExp(b) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(k) => { if (eval(k)) false else true }
      case AndAlso(a, b) => { if (eval(a) && eval(b)) true else false }
      case OrElse(a, b) => { if (eval(a) || eval(b)) true else false }
      case Imply(a, b) => { if (eval(a) && eval(Not(b))) false else true }
      case Equal(a, b) => { if (evalExp(a) == evalExp(b)) true else false }
    }
  }
}