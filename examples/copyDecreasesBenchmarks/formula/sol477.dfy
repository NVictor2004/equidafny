import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol477 {
  
  
  def expSol(e: Exp): Exp = {
    e match {
      case Num(a) => { Num(a) }
      case Plus(p1, p2) => {
        (p1, p2) match {
          case (Num(a), Num(b)) => { Num(a + b) }
          case (a, b) => { expSol(Plus(expSol(a), expSol(b))) }
        }
      }
      case Minus(m1, m2) => {
        (m1, m2) match {
          case (Num(a), Num(b)) => { Num(a - b) }
          case (a, b) => { expSol(Minus(expSol(a), expSol(b))) }
        }
      }
    }
  }
  
  def preEval(form: Formula): Formula = {
    form match {
      case True_ => { True_ }
      case False_ => { False_ }
      case Not(f) => {
        f match {
          case True_ => { False_ }
          case False_ => { True_ }
          case a => { preEval(Not(preEval(f))) }
        }
      }
      case AndAlso(f1, f2) => {
        (f1, f2) match {
          case (True_, True_) => { True_ }
          case (False_, b) => { False_ }
          case (a, False_) => { False_ }
          case (a, b) => { preEval(AndAlso(preEval(a), preEval(b))) }
        }
      }
      case OrElse(f1, f2) => {
        (f1, f2) match {
          case (False_, False_) => { False_ }
          case (True_, b) => { True_ }
          case (a, True_) => { True_ }
          case (a, b) => { preEval(OrElse(preEval(a), preEval(b))) }
        }
      }
      case Imply(f1, f2) => {
        (f1, f2) match {
          case (True_, False_) => { False_ }
          case (True_, True_) => { True_ }
          case (False_, b) => { True_ }
          case (a, b) => { preEval(Imply(preEval(a), preEval(b))) }
        }
      }
      case Equal(e1, e2) => {
        (e1, e2) match {
          case (Num(a), Num(b)) => { if (a == b) True_ else False_ }
          case (a, b) => { preEval(Equal(expSol(a), expSol(b))) }
        }
      }
    }
  }
  
  def eval(form: Formula): Boolean = {
    form match {
      case True_ => { true }
      case False_ => { false }
      case Not(f) => {
        f match {
          case True_ => { false }
          case False_ => { true }
          case a => { eval(Not(preEval(f))) }
        }
      }
      case AndAlso(f1, f2) => {
        (f1, f2) match {
          case (True_, True_) => { true }
          case (False_, b) => { false }
          case (a, False_) => { false }
          case (a, b) => { eval(AndAlso(preEval(a), preEval(b))) }
        }
      }
      case OrElse(f1, f2) => {
        (f1, f2) match {
          case (False_, False_) => { false }
          case (True_, b) => { true }
          case (a, True_) => { true }
          case (a, b) => { eval(OrElse(preEval(a), preEval(b))) }
        }
      }
      case Imply(f1, f2) => {
        (f1, f2) match {
          case (True_, False_) => { false }
          case (True_, True_) => { true }
          case (False_, b) => { true }
          case (a, b) => { eval(Imply(preEval(a), preEval(b))) }
        }
      }
      case Equal(e1, e2) => {
        (e1, e2) match {
          case (Num(a), Num(b)) => { if (a == b) true else false }
          case (a, b) => { eval(Equal(expSol(a), expSol(b))) }
        }
      }
    }
  }
  
  
  		
}