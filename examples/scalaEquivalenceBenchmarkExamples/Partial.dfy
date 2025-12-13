/* Copyright 2009-2024 EPFL, Lausanne */
/* From ESOP 2014, Kuwahara et al */



ghost function existsM<T(!new)>(p: T -> bool): bool
  ensures existsM(p) <==> exists t: T :: p(t)
{
  ! forall t: T :: !p(t)
}

ghost function eliminate_existsM<T(!new)>(p: T -> bool): T
  requires (existsM(p))
  ensures (p(eliminate_existsM(p))) {
  var res :| p(res);
  res
}

ghost function maxNegPM(j: int, p: int -> bool): bool {
  !p(j) && forall k :: !p(k) ==> (k <= j)
}

ghost function fM(x: int, p: int -> bool): int
  requires (!p(x) || existsM((j: int) => j < x && maxNegPM(j, p)))
  decreases(if (!p(x)) then 0 else x - eliminate_existsM((j: int) => j < x && maxNegPM(j, p))) {
  if (p(x)) then 
    var j :| j < x && !p(j) && forall k :: !p(k) ==> (k <= j);
    assert j < x - 1 ==> exists j :: ((j: int) => j < x - 1 && maxNegPM(j, p))(j);
    fM(x - 1, p)
  else x
  }

ghost function existsF<T(!new)>(p: T -> bool): bool {
  ! forall t :: !p(t)
}

ghost function maxNegP(p: int -> bool, j: int): bool {
  if p(j) then
    false
  else
    forall k :: !p(k) ==> (k <= j)
}

function f(x: int, p: int -> bool): int
  requires (!p(x) || existsF((j: int) => j < x && maxNegP(p, j)))
  decreases(if (!p(x)) then 0 else x - eliminate_existsM((j: int) => j < x && maxNegPM(j, p))) {
  var t := p(x);
  if t then f(x - 1, p)
  else x
  }