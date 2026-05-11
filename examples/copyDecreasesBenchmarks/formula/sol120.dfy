import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol120 {
  
  def eval_exp(e: Exp): Int = {
    e match {
      case Num(x) => { x }
      case Plus(e_1, e_2) => { eval_exp(e_1) + eval_exp(e_2) }
      case Minus(e_1, e_2) => { eval_exp(e_1) - eval_exp(e_2) }
    }
  }
  def eval(f: Formula): Boolean = {
    f match {
      case True_ => { true }
      case False_ => { false }
      case Not(f_) => { !eval(f_) }
      case AndAlso(f_1, f_2) => { eval(f_1) && eval(f_2) }
      case OrElse(f_1, f_2) => { eval(f_1) || eval(f_2) }
      case Imply(f_1, f_2) => { eval(AndAlso(f_1, f_2)) || eval(Not(f_1)) }
      case Equal(e_1, e_2) => { eval_exp(e_1) == eval_exp(e_2) }
    }
  }
  	
  /* TEST SET*/
  /*
  let _ =
      print_string "HW6 Test Set
  ";
      Printf.printf ("%b") (eval (Not True));
      print_newline ();
      Printf.printf ("%b") (eval (AndAlso(Equal(Num 10, Num 5), Equal(Plus (Num 4, Num 5) , Minus (Num 50, Num 1)))));
      print_newline ();
      Printf.printf ("%b") (eval (Not (AndAlso (Equal (Num 0, Num 0), True))));
      print_newline ();
      Printf.printf ("%b") (eval (Imply(Equal (Num 0, Num 1), AndAlso(Equal (Num 0, Num 0), Not True))));
      print_newline ();
      Printf.printf ("%b") (eval (Imply(Equal (Num 1, Num 0), OrElse(AndAlso(True, False), OrElse(Not True, Equal(Num 1, Num 2))))));
      print_newline ()
  */
}