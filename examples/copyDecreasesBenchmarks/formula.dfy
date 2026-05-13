datatype Formula = 
  True_
  | False_
  | Not(param0: Formula)
  | AndAlso(param0: Formula, param1: Formula)
  | OrElse(param0: Formula, param1: Formula)
  | Imply(param0: Formula, param1: Formula)
  | Equal(left: Exp, right: Exp)

datatype Exp = Num(num: int) | Plus(param0: Exp, param1: Exp) | Minus(param0: Exp, param1: Exp)

function size(f: Formula): int
  ensures size(f) >= 0
{
  match f {
    case True_ => 0
    case False_ => 0
    case Not(p) => 1 + size(p)
    case AndAlso(p0, p1) => 2 + size(p0) + size(p1)
    case OrElse(p0, p1) => 2 + size(p0) + size(p1)
    case Imply(p0, p1) => 10 + size(p0) + size(p1)
    case Equal(_, _) => 1
  }
}

function evall(e: Exp): int {
  match e {
    case Num(a) => a
    case Plus(a, b) => evall(a) + evall(b)
    case Minus(a, b) => evall(a) - evall(b)
  }
}

// The termination clause here needed to be manually put in
function eval(f: Formula): bool
  decreases size(f)
{
  match f {
    case True_ => true
    case False_ => false
    case Not(a) => if (eval(a)) then false else true
    case AndAlso(a, b) => eval(a) && eval(b)
    case OrElse(a, b) => eval(a) || eval(b)
    case Imply(a, b) =>
      assert size(Not(AndAlso(a, Not(b)))) < size(Imply(a, b));
      eval(Not(AndAlso(a, Not(b))))
    case Equal(a, b) => if (evall(a) == evall(b)) then true else false
  }
}