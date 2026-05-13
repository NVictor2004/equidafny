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

function exp_evalM(exp: Exp): int {
  match exp {
    case Num(n) => n
    case Plus(e1, e2) => exp_evalM(e1) + exp_evalM(e2)
    case Minus(e1, e2) => exp_evalM(e1) - exp_evalM(e2)
  }
}

function evalM(f: Formula): bool
  decreases(size(f))
{
  match f {
    case True_ => true
    case False_ => false
    case Not(f) => !(evalM(f))
    case AndAlso(p1, p2) =>
      var p11 := evalM(p1);
      var p22 := evalM(p2);
      p11 && p22
    case OrElse(p1, p2) =>
      var p11 := evalM(p1);
      var p22 := evalM(p2);
      p11 || p22
    case Imply(p1, p2)  =>
      var p11 := evalM(p1);
      var p22 := evalM(p2);
      !(p11) || p22
    case Equal(p1, p2) =>
      exp_evalM(p1) == exp_evalM(p2)
  }
}
