import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol490 {
  
  
  def calc(e: Exp): Int = {
    e match {
      case Num(a) => { a }
      case Plus(a, b) => { calc(a) + calc(b) }
      case Minus(a, b) => { calc(a) - calc(b) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f1) => { !eval(f1) }
      case AndAlso(f1, f2) => { eval(f1) && eval(f2) }
      case OrElse(f1, f2) => { eval(f1) || eval(f2) }
      case Imply(f1, f2) => { eval(OrElse(Not(f1), f2)) }
      case Equal(e1, e2) => { calc(e1) == calc(e2) }
    }
  }
}
