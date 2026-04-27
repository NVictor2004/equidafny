import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol574 {
  
    
  def calc(e: Exp): Int = {
    e match {
      case Num(n) => { n }
      case Plus(num1, num2) => { calc(num1) + calc(num2) }
      case Minus(num1, num2) => { calc(num1) - calc(num2) }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f) => { !eval(f) }
      case AndAlso(f1, f2) => { eval(f1) && eval(f2) }
      case OrElse(f1, f2) => { eval(f1) || eval(f2) }
      case Imply(f1, f2) => { if (eval(f1)) eval(f2) else eval(True_) }
      case Equal(f1, f2) => { calc(f1) == calc(f2) }
    }
  }
      
  /* eval(Imply(Imply(True_, False_), True_)) */
  /* eval(Equal(Num(1), Plus(Num(1), Num(2)))) */
}