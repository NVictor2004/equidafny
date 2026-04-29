import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol77 {
  /* 2009-11824 Jieun-Jeong HW1-5 */
  
  
  
  def eval(f: Formula): Boolean = {
    def calc(e: Exp): Int = {
      e match {
        case Num(n) => { n }
        case Plus(el, er) => { calc(el) + calc(er) }
        case Minus(el, er) => { calc(el) - calc(er) }
      }
    }
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f) => { if (eval(f)) false else true }
      case AndAlso(fl, fr) => { eval(fl) && eval(fr) }
      case OrElse(fl, fr) => { eval(fl) || eval(fr) }
      case Imply(fl, fr) => { eval(Not(fl)) || eval(fr) }
      case Equal(el, er) => { calc(el) == calc(er) }
    }
    
  }	
}