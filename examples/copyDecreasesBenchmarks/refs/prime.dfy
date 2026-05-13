
/* Copyright 2022 EPFL, Lausanne */


// ./stainless ../evaluation/Prime.scala --timeout=2 --solvers=smt-z3 --equivchk=true --models=isPrimeM --comparefuns=isPrime  --vc-cache=false
// source: epfl softcon 2023

function recM(n: int, i: int): int
  requires(n >= 0 && i > 0 && i-1 <= n)
  decreases(n-i+1)
  ensures recM(n, i) >= 0 // Added this line
{
  if i == n / i then i
  else if i > n / i then i - 1
  else recM(n, i+1)
}

function isqrtM(n: int): int
  requires(n >= 0)
{
  recM(n, 1)
}

function innerM1(k: int, ref: int): bool
  requires(k > 0 && ref > 0 && ref <= k)
  decreases(k-ref)
{
  if ref > isqrtM(k) then
    true
  else
    if k%ref == 0 then
      false
    else
      innerM1(k, ref+1)
}

function isPrimeM1(n: int): bool
  requires(n >= 0)
{
  if n <= 1 then
    false
  else
    innerM1(n, 2)
}

function innterM2(n: int, i: int): bool
  requires(n >= 0 && i > 1 && i <= n)
  decreases(n-i)
{
  if (i >= n) then true
  else if (n % i == 0) then false
  else innterM2(n, i + 1)
}

function isPrimeM2(n: int): bool
  requires(n >= 0)
{
  if (n == 0 || n == 1) then
    false
  else
    innterM2(n, 2)
}

function isPrimeHelperC(n: int, i: int): bool
  requires i >= 0 // Added this line
  decreases i // Added this line
{
  if i == 1 || i == 0 then true 
  else n%i != 0 && isPrimeHelperC(n, i-1)
}

function isPrimeC(n: int): bool 
  requires(n >= 0)
{
  if n == 0 || n == 1 then false 
  else isPrimeHelperC(n, isqrtM(n))
}