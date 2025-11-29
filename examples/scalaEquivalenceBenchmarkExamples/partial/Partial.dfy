/* Copyright 2009-2024 EPFL, Lausanne */
/* From ESOP 2014, Kuwahara et al */



method existsM[T](p: T => bool) returns (res: bool)
  !forall((t: T) => !p(t))

method eliminate_existsM[T](p: T => bool) returns (res: T)
  requires (existsM[T](p))
  choose[T]((res: T) => p(res))
}.ensuring(p)

method maxNegPM(j: int, p: int => bool) returns (res: bool)
  !p(j) && forall((k: int) => !p(k) ==> (k <= j))

method fM(x: int, p: int => bool) returns (res: int)
  requires (!p(x) || existsM[int]((j: int) => j < x && maxNegPM(j, p)))
  decreases(if (!p(x)) int(0) else x - eliminate_existsM[int]((j: int) => j < x && maxNegPM(j, p))) {
  if (p(x))  fM(x - 1, p)
  else  x


method exists[T](p: T => bool) returns (res: bool)
  !forall((t: T) => !p(t))

method maxNegP(p: int => bool, j: int) returns (res: bool)
  if p(j) 
    false
  else
    forall((k: int) => !p(k) ==> (k <= j))

method f(x: int, p: int => bool) returns (res: int)
  requires (!p(x) || exists[int]((j: int) => j < x && maxNegP(p, j)))
  decreases(if (!p(x)) int(0) else x - eliminate_existsM[int]((j: int) => j < x && maxNegPM(j, p))) {
  var t := p(x);
  if t  f(x - 1, p)
  else x
