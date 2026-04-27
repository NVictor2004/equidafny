import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol572 {
  
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(x) => { eval(if (eval(x) == true) False_ else True_) }
      case AndAlso(x, y) => {
        eval(if (eval(x) == true && eval(y) == true) True_ else False_)
      }
      case OrElse(x, y) => {
        eval(if (eval(x) == true || eval(y) == true) True_ else False_)
      }
      case Imply(x, y) => {
        eval(if (eval(x) == true && eval(y) == false) False_ else True_)
      }
      case Equal(x, y) => { eval(if (ex(x) == ex(y)) True_ else False_) }
    }
  }
  def ex(e: Exp): Int = {
    e match {
      case Plus(x, y) => { ex(x) + ex(y) }
      case Minus(x, y) => { ex(x) - ex(y) }
      case Num(x) => { x }
    }
  }
    
  /* eval(Imply(Imply(True_, False_), True_)) */
  /* eval(Equal(Num(1), Plus(Num(1), Num(2)))) */
    
    
    
}