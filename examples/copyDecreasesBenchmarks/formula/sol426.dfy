import benchmarks_formula_defs._
import stainless.lang._

object C_formula_sol426 {
  
  
  
  
  def eval(form: Formula): Boolean = {
    
    def expTOINT(exp: Exp): Int = {
      exp match {
        case Num(a) => { a }
        case Plus(a, b) => { expTOINT(a) + expTOINT(b) }
        case Minus(a, b) => { expTOINT(a) - expTOINT(b) }
      }
    }
    
    def formTOBool(form: Formula): Boolean = {
      form match {
        case True_ => { true }
        case False_ => { false }
        case Not(a) => { !formTOBool(a) }
        case AndAlso(a, b) => { formTOBool(a) && formTOBool(b) }
        case OrElse(a, b) => { formTOBool(a) || formTOBool(b) }
        case Imply(a, b) => {
          if (formTOBool(a) == true && formTOBool(b) == false) false else true
        }
        case Equal(h, t) => {
          
            if (
              expTOINT(h) == expTOINT(t)
            ) {
              formTOBool(True_) 
            } else {
              formTOBool(False_)
            }
        }
      }
    }
    formTOBool(form)
    
    
  }
  	
}