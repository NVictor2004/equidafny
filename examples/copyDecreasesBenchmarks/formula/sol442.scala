import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol442 {
  
  
  def plusminus(x: Exp): Int = {
    x match {
      case Plus(a, b) => { plusminus(a) + plusminus(b) }
      case Minus(a, b) => { plusminus(a) - plusminus(b) }
      case Num(a) => { a }
    }
  }
  
  
  def eval_help(f: Formula): Formula = {
    f match {
      case False_ => { False_ }
      case True_ => { True_ }
      case Not(value) => {
        value match {
          case True_ => { False_ }
          case False_ => { True_ }
          case _ => { eval_help(Not(eval_help(value))) }
        }
      }
      case AndAlso(value, value1) => {
        value match {
          case True_ => {
            value1 match {
              case True_ => { True_ }
              case False_ => { False_ }
              case _ => {
                eval_help(AndAlso(eval_help(value), eval_help(value1)))
              }
            }
          }
          case False_ => { False_ }
          case _ => { eval_help(AndAlso(eval_help(value), eval_help(value1))) }
        }
      }
      case OrElse(value, value1) => {
        value match {
          case True_ => { True_ }
          case False_ => {
            value1 match {
              case True_ => { True_ }
              case False_ => { False_ }
              case _ => { eval_help(OrElse(eval_help(value), eval_help(value1)))
              }
            }
          }
          case _ => { eval_help(OrElse(eval_help(value), eval_help(value1))) }
        }
      }
      case Imply(value, value1) => {
        value match {
          case False_ => { True_ }
          case True_ => {
            value1 match {
              case False_ => { False_ }
              case True_ => { True_ }
              case _ => { eval_help(Imply(eval_help(value), eval_help(value1)))
              }
            }
          }
          case _ => { eval_help(Imply(eval_help(value), eval_help(value1))) }
        }
      }
      case Equal(value, value1) => {
        (value, value1) match {
          case (a, b) => { if (plusminus(a) == plusminus(b)) True_ else False_ }
        }
      }
    }
  }
  
  def eval(f: Formula): Boolean = {
    
    val returned = eval_help(f)
    returned match {
      case True_ => { true }
      case False_ => { false }
      case _ => { false }
    }
    
  }
  
  /* let _ =
    let test_case : int * bool -> unit = fun (n, x) ->
      print_endline ("Case " ^ string_of_int(n) ^ " : " ^ string_of_bool(x)) in
    test_case(1, true = eval True);
    test_case(2, false = eval False);
    test_case(3, false = eval (Not True));
    test_case(4, true = eval (Not False));
    test_case(5, true = eval (AndAlso (True, True)));
    test_case(6, false = eval (AndAlso (True, False)));
    test_case(7, false = eval (AndAlso (False, True)));
    test_case(8, false = eval (AndAlso (False, False)));
    test_case(9, true = eval (OrElse (True, True)));
    test_case(10, true = eval (OrElse (True, False)));
    test_case(11, true = eval (OrElse (False, True)));
    test_case(12, false = eval (OrElse (False, False)));
    test_case(13, false = eval (Imply (True, False)));
    test_case(14, true = eval (Imply (True, True)));
    test_case(15, true = eval (Imply (False, True)));
    test_case(16, true = eval (Imply (False, False)));
    test_case(17, true = eval (Equal (Num 3, Num 5)));
    test_case(18, false = eval (Equal (Num 3, Num 3)));
    test_case(19, false = eval (Equal (Num 3, Num 1)));
    test_case(20, false = eval (Equal (Plus (Num 3, Num 4), Minus (Num 5, Num 1))));
    test_case(21, true = eval (Equal (Plus (Num 10, Num 12), Minus (Num 10, Num (-13)))));
    test_case(22, true = eval (AndAlso (Not False, True)));
    test_case(23, true = eval (OrElse (Imply(Equal (Num (-10), Num (-100)), AndAlso (Not True, True)), AndAlso (True, AndAlso (Equal (Num 10, Plus (Minus (Num 10, Num (-10)), Num 30)), True)))));
    test_case (24, true = eval (Imply(Equal (Num (-10), Num (-100)), AndAlso (Not True, True))));
    test_case (25, false = eval(Equal(Num (100), Num (10))));
    test_case (26, false = eval(AndAlso(Not True, True)));
    test_case (27, false = eval(Not(Not False))); */
}