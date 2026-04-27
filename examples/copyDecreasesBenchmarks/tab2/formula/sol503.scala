import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol503 {
  
  
  def eval_number(f: Exp): Int = {
    f match {
      case Num(f) => { f }
      case Plus(f1, f2) => { eval_number(f1) + eval_number(f2) }
      case Minus(f1, f2) => { eval_number(f1) - eval_number(f2) }
    }
  }
  	
  def eval_formula(f: Formula): Formula = {
    f match {
      case True_ => { True_ }
      case False_ => { False_ }
      case Not(True_) => { False_ }
      case Not(False_) => { True_ }
      case Not(f1) => { eval_formula(Not(eval_formula(f1))) }
      case AndAlso(True_, True_) => { True_ }
      case AndAlso(False_, _) => { False_ }
      case AndAlso(_, False_) => { False_ }
      case AndAlso(f1, f2) => {
        eval_formula(AndAlso(eval_formula(f1), eval_formula(f2)))
      }
      case OrElse(True_, _) => { True_ }
      case OrElse(_, True_) => { True_ }
      case OrElse(False_, False_) => { False_ }
      case OrElse(f1, f2) => {
        eval_formula(OrElse(eval_formula(f1), eval_formula(f2)))
      }
      case Imply(True_, True_) => { True_ }
      case Imply(True_, False_) => { False_ }
      case Imply(False_, _) => { True_ }
      case Imply(f1, f2) => {
        eval_formula(Imply(eval_formula(f1), eval_formula(f2)))
      }
      case Equal(f1, f2) => {
        if (eval_number(f1) == eval_number(f2)) True_ else False_
      }
    }
  }
  def eval(f: Formula): Boolean = {
    if (eval_formula(f) == True_) true else false
  }
}
