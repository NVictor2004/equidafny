import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol549 {
  
  
  
  
  def cal(input: Exp): Int = {
    input match {
      case Num(a) => { a }
      case Plus(a, b) => { cal(a) + cal(b) }
      case Minus(a, b) => { cal(a) - cal(b) }
    }
  }
  
  def eval(input: Formula): Boolean = {
    input match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => { !eval(a) }
      case AndAlso(a, b) => { eval(a) && eval(b) }
      case OrElse(a, b) => { eval(a) || eval(b) }
      case Imply(a, b) => { !(eval(a) && !eval(b)) }
      case Equal(x, y) => { if (cal(x) == cal(y)) eval(True_) else eval(False_)
      }
    }
  }
  
}
