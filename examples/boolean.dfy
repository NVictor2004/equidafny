
// Defining a simple boolean Formula datatype
datatype Formula = 
  True 
| False 
| Not(f: Formula) 
| Imply(left: Formula, right: Formula)

function size(f: Formula): nat
{
    match f
    case True => 1
    case False => 1
    case Not(f) => 1 + size(f)
    case Imply(l, r) => 2 + size(l) + size(r)
}

// Dafny cannot prove termination for the last clause
function eval(f: Formula): bool
    decreases size(f)
{
    match f
    case True => true
    case False => false
    case Not(f) => if (eval(f)) then false else true
    case Imply(l, r) => eval(Not(l)) || eval(r)
}