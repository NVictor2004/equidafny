
// Defining a simple boolean Formula datatype
datatype Formula = 
  True 
| False 
| Not(f: Formula) 
| Imply(left: Formula, right: Formula)

// Dafny cannot prove termination for the last clause
function eval(f: Formula): bool
    decreases f
{
    match f
    case True => true
    case False => false
    case Not(f) => if (eval(f)) then false else true
    case Imply(fl, fr) => eval(Not(fl)) || eval(fr)
}