import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol379 {
   
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(k) => { if (eval(k) == eval(True_)) false else true }
      case AndAlso(p, q) => {
        if (eval(p) == eval(True_) && eval(q) == eval(True_)) true else false
      }
      case OrElse(p, q) => {
        if (eval(p) == eval(False_) && eval(q) == eval(False_)) false else true
      }
      case Imply(p, q) => {
        if (eval(p) == eval(True_) && eval(q) == eval(False_)) false else true
      }
      case Equal(p, q) => { if (eval2(p) == eval2(q)) true else false }
    }
  }
  def eval2(g: Exp): Int = {
    g match {
      case Num(i) => { i }
      case Plus(j, k) => { eval2(j) + eval2(k) }
      case Minus(j, k) => { eval2(j) - eval2(k) }
    }
  }
  
    
  
   /* TODO */
}
