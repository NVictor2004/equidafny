import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol563 {
  
  
  def expr(e: Exp): Int = {
    e match {
      case Num(num) => { num }
      case Plus(left, right) => { expr(left) + expr(right) }
      case Minus(left, right) => { expr(left) - expr(right) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    
    def div(f: Formula): Boolean = {
      f match {
        case True_ => { true }
        case False_ => { false }
        case Not(ev) => { if (div(ev)) false else true }
        case AndAlso(left, right) => { div(left) && div(right) }
        case OrElse(left, right) => { div(left) || div(right) }
        case Imply(left, right) => { div(Not(left)) || div(right) }
        case Equal(left, right) => { expr(left) == expr(right) }
      }
    }
    div(f)
    
  }
}