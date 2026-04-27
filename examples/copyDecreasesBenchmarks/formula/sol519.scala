import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol519 {
  /*
  	CSE / 2013-11426 / Im DongYeop
  	Homework 2: Exercise 1
  */
  
  
  
  def gonum(e: Exp): Exp = {
    e match {
      case Num(ein) => { Num(ein) }
      case Plus(ein1, ein2) => {
        (ein1, ein2) match {
          case (Num(eein1), Num(eein2)) => { Num(eein1 + eein2) }
          case _ => { gonum(Plus(gonum(ein1), gonum(ein2))) }
        }
      }
      case Minus(ein1, ein2) => {
        (ein1, ein2) match {
          case (Num(eein1), Num(eein2)) => { Num(eein1 - eein2) }
          case _ => { gonum(Minus(gonum(ein1), gonum(ein2))) }
        }
      }
    }
  }
  
  def goform(f: Formula): Formula = {
    f match {
      case True_ => { True_ }
      case False_ => { False_ }
      case Not(ff) => {
        ff match {
          case True_ => { False_ }
          case False_ => { True_ }
          case _ => { Not(goform(ff)) }
        }
      }
      case AndAlso(f1, f2) => {
        (f1, f2) match {
          case (True_, True_) => { True_ }
          case (False_, _) => { False_ }
          case (_, False_) => { False_ }
          case _ => { AndAlso(goform(f1), goform(f2)) }
        }
      }
      case OrElse(f1, f2) => {
        (f1, f2) match {
          case (False_, False_) => { False_ }
          case (True_, _) => { True_ }
          case (_, True_) => { True_ }
          case _ => { OrElse(goform(f1), goform(f2)) }
        }
      }
      case Imply(f1, f2) => {
        (f1, f2) match {
          case (True_, False_) => { False_ }
          case (_, True_) => { True_ }
          case (False_, False_) => { True_ }
          case _ => { Imply(goform(f1), goform(f2)) }
        }
      }
      case Equal(e1, e2) => {
        (e1, e2) match {
          case (Num(ein1), Num(ein2)) => { if (ein1 == ein2) True_ else False_ }
          case _ => { Equal(gonum(e1), gonum(e2)) }
        }
      }
    }
  }
  
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(ff) => { eval(goform(Not(ff))) }
      case AndAlso(f1, f2) => { eval(goform(AndAlso(f1, f2))) }
      case OrElse(f1, f2) => { eval(goform(OrElse(f1, f2))) }
      case Imply(f1, f2) => { eval(goform(Imply(f1, f2))) }
      case Equal(e1, e2) => {
        (e1, e2) match {
          case (Num(ein1), Num(ein2)) => { ein1 == ein2 }
          case _ => { eval(Equal(gonum(e1), gonum(e2))) }
        }
      }
    }
  }
}
