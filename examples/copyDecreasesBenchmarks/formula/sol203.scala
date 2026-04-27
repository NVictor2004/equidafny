import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol203 {
  
  
  def eval(p: Formula): Boolean = {
    p match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => { !eval(a) }
      case AndAlso(a, b) => { eval(a) && eval(b) }
      case OrElse(a, b) => { eval(a) || eval(b) }
      case Imply(a, b) => { eval(Not(a)) || eval(b) }
      case Equal(a, b) => { if (my_exp(a) == my_exp(b)) true else false }
    }
  }
  def my_exp(p: Exp): Int = {
    p match {
      case Num(b) => { b }
      case Plus(a, b) => { my_exp(a) + my_exp(b) }
      case Minus(a, b) => { my_exp(a) - my_exp(b) }
    }
  }
}