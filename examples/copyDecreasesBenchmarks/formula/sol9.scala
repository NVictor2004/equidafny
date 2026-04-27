import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol9 {
  
  
  def eval(formula: Formula): Boolean = {
    def temp(exp: Exp): Int = {
      exp match {
        case Num(a) => { a }
        case Plus(a, b) => { temp(a) + temp(b) }
        case Minus(a, b) => { temp(a) - temp(b) }
      }
    }
    formula match {
      case True_ => { true }
      case False_ => { false }
      case Not(f1) => { if (eval(f1) == true) false else true }
      case AndAlso(f1, f2) => { eval(f1) && eval(f2) }
      case OrElse(f1, f2) => { eval(f1) || eval(f2) }
      case Imply(f1, f2) => { eval(f1) && eval(f2) || eval(Not(f1)) }
      case Equal(e1, e2) => { if (temp(e1) == temp(e2)) true else false }
    }
    
  }
  
  val a: Formula = True_
  val b: Formula = False_
  val c: Formula = Not(True_)
  val d: Exp = Plus(Num(1), Num(2))
  val e: Exp = Minus(Num(4), Num(3))
}