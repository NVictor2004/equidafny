import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol523 {
  
  
  def exp_to_int(x: Exp): Int = {
    x match {
      case Num(x) => { x }
      case Plus(a, b) => { exp_to_int(a) + exp_to_int(b) }
      case Minus(a, b) => { exp_to_int(a) - exp_to_int(b) }
    }
  }
  
  def eval_less(x: Int, y: Int): Boolean = { x == y }
  
  def bool_to_formula(b: Boolean): Formula = {
    b match {
      case true => { True_ }
      case false => { False_ }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(a) => {
        a match {
          case True_ => { false }
          case False_ => { true }
          case a => { eval(Not(bool_to_formula(eval(a)))) }
        }
      }
      case AndAlso(a, b) => {
        (a, b) match {
          case (True_, True_) => { true }
          case (True_, False_) => { false }
          case (False_, True_) => { false }
          case (False_, False_) => { false }
          case (a, b) => {
            eval(AndAlso(bool_to_formula(eval(a)), bool_to_formula(eval(b))))
          }
        }
      }
      case OrElse(a, b) => {
        (a, b) match {
          case (True_, True_) => { true }
          case (True_, False_) => { true }
          case (False_, True_) => { true }
          case (False_, False_) => { false }
          case (a, b) => {
            eval(OrElse(bool_to_formula(eval(a)), bool_to_formula(eval(b))))
          }
        }
      }
      case Imply(a, b) => {
        (a, b) match {
          case (True_, True_) => { true }
          case (False_, True_) => { true }
          case (True_, False_) => { false }
          case (False_, False_) => { true }
          case (a, b) => {
            eval(Imply(bool_to_formula(eval(a)), bool_to_formula(eval(b))))
          }
        }
      }
      case Equal(c, d) => { eval_less(exp_to_int(c), exp_to_int(d)) }
    }
  }
}