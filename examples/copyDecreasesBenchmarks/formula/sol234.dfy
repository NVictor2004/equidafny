import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol234 {
  
  
  
  
  def calculate(e: Exp): Int = {
    e match {
      case Num(n) => { n }
      case Plus(a, b) => { calculate(a) + calculate(b) }
      case Minus(a, b) => { calculate(a) - calculate(b) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => { !eval(a) }
      case AndAlso(a, b) => { eval(a) && eval(b) }
      case OrElse(a, b) => { eval(a) || eval(b) }
      case Imply(a, b) => { eval(a) == false || eval(AndAlso(a, b)) }
      case Equal(a, b) => { calculate(a) == calculate(b) }
    }
  }
}