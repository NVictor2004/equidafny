import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol205 {
  sealed case class EvalError() extends Exception {}
  
  def eval(f: Formula): Boolean = {
    def eval_exp(e: Exp): Exp = {
      e match {
        case Num(n) => { Num(n) }
        case Plus(Num(n1), Num(n2)) => { Num(n1 + n2) }
        case Plus(e1, e2) => { eval_exp(Plus(eval_exp(e1), eval_exp(e2))) }
        case Minus(Num(n1), Num(n2)) => { Num(n1 - n2) }
        case Minus(e1, e2) => { eval_exp(Minus(eval_exp(e1), eval_exp(e2))) }
      }
    }
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f1) => { !eval(f1) }
      case AndAlso(f1, f2) => { eval(f1) && eval(f2) }
      case OrElse(f1, f2) => { eval(f1) || eval(f2) }
      case Imply(f1, f2) => { !eval(f1) || eval(f2) }
      case Equal(e1, e2) => {
        (eval_exp(e1), eval_exp(e2)) match {
          case (Num(n1), Num(n2)) => { n1 == n2 }
          case _ => { choose((x: Boolean) => true) }
        }
      }
    }
    
  }
}