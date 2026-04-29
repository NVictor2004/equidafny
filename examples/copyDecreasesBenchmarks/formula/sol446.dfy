import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol446 {
  
  
  def expval(f: Exp): Int = {
    f match {
      case Num(a) => { a }
      case Plus(a, b) => { expval(a) + expval(b) }
      case Minus(a, b) => { expval(a) - expval(b) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(g) => { if (eval(g)) false else true }
      case AndAlso(a, b) => { eval(a) && eval(b) }
      case OrElse(a, b) => { eval(a) || eval(b) }
      case Imply(a, b) => { eval(Not(a)) || eval(b) }
      case Equal(x, y) => { expval(x) == expval(y) }
    }
  }
}