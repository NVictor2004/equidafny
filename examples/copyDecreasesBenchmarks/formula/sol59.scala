import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol59 {
  /* 2004-11951 Noh, Soon Hyun */
  
  /* skeleton type from TA */
  
  
  
  /* to evaluete expessions */
  def evalexp(v: Exp): Int = {
    v match {
      case Num(x) => { x }
      case Plus(x, y) => { evalexp(x) + evalexp(y) }
      case Minus(x, y) => { evalexp(x) - evalexp(y) }
    }
  }
  
  /* middle-level function of eval */
  /* If I use =formula> -> =bool> function direct to recursion,
  I cannot use return value to its argument again */
  /* type of protoeval f is =formula> -> =formula> */
  def protoeval(f: Formula): Formula = {
    f match {
      case True_ => { True_ }
      case False_ => { False_ }
      case Not(True_) => { False_ }
      case Not(False_) => { True_ }
      case Not(x) => { protoeval(Not(protoeval(x))) }
      case AndAlso(False_, False_) => { False_ }
      case AndAlso(True_, False_) => { False_ }
      case AndAlso(False_, True_) => { False_ }
      case AndAlso(True_, True_) => { True_ }
      case AndAlso(x, y) => { protoeval(AndAlso(protoeval(x), protoeval(y))) }
      case OrElse(False_, False_) => { False_ }
      case OrElse(True_, False_) => { True_ }
      case OrElse(False_, True_) => { True_ }
      case OrElse(True_, True_) => { True_ }
      case OrElse(x, y) => { protoeval(OrElse(protoeval(x), protoeval(y))) }
      case Imply(False_, False_) => { True_ }
      case Imply(True_, False_) => { False_ }
      case Imply(False_, True_) => { True_ }
      case Imply(True_, True_) => { True_ }
      case Imply(x, y) => { protoeval(Imply(protoeval(x), protoeval(y))) }
      case Equal(a, b) => { if (evalexp(a) == evalexp(b)) True_ else False_ }
    }
  }
  
  /* main function */
  def eval(f: Formula): Boolean = {
    
      if (
        protoeval(f) == True_
      ) {
        true 
      } else if (
        protoeval(f) == False_
      ) {
        false 
      } else {
        false
      }
  }
  
  /* Test Code :: some parts are refrenced from last semester class web board
  let test = eval(Equal(Plus(Num 5, Num 5), Minus(Num 20, Num 13)))
  let print_bool a =
  	if a=true then print_string "true
  "
  	else print_string "false
  "
  
  let f p q = eval (AndAlso (p, (OrElse (q, (AndAlso ((Not p), (Not q)))))));; 
  let r_f p q = not (f p q);;
  let _ = print_bool (f True True) 
  let _ = print_bool (f True False) 
  let _ = print_bool (f False True) 
  let _ = print_bool (f False False) 
  let _ = print_bool (r_f True True) 
  let _ = print_bool (r_f True False) 
  let _ = print_bool (r_f False True) 
  let _ = print_bool (r_f False False)
  
  let _ = print_bool test
  */
}