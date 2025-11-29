

































/* Copyright 2009-2024 EPFL, Lausanne */
/* From ESOP 2014, Kuwahara et al */



function existsM<T>(p: T => bool): bool
  !forall((t: T) => !p(t))

function eliminate_existsM<T>(p: T => bool): T
  requires (existsM[T](p))
  choose[T]((res: T) => p(res))
}.ensuring(p)

function maxNegPM(j: int, p: int => bool): bool
  !p(j) && forall((k: int) => !p(k) ==> (k <= j))

function fM(x: int, p: int => bool): int
  requires (!p(x) || existsM[int]((j: int) => j < x && maxNegPM(j, p)))
  decreases(if (!p(x)) int(0) else x - eliminate_existsM[int]((j: int) => j < x && maxNegPM(j, p))) {
  if (p(x)) then  fM(x - 1, p)
  else  x


function exists<T>(p: T => bool): bool
  !forall((t: T) => !p(t))

function maxNegP(p: int => bool, j: int): bool
  if p(j) 
    false
  else
    forall((k: int) => !p(k) ==> (k <= j))

function f(x: int, p: int => bool): int
  requires (!p(x) || exists[int]((j: int) => j < x && maxNegP(p, j)))
  decreases(if (!p(x)) int(0) else x - eliminate_existsM[int]((j: int) => j < x && maxNegPM(j, p))) {
  var t := p(x);
  if t  f(x - 1, p)
  else x
