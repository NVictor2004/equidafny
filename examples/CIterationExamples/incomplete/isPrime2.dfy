// MODEL

const PRIMESM: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

function LibM(x: nat, b: int): int {
  if b == 0 then 
    0 
  else 
    LibLoopM(x, 0)
}

function LibLoopM(x: nat, i: int): int
  requires 0 <= i
  requires i <= |PRIMESM|
  decreases |PRIMESM| - i
{
  if i == |PRIMESM| then 
    1
  else
    var p := PRIMESM[i];
    if x % p == 0 then
      if x == p then 1 else 0
    else
      LibLoopM(x, i + 1)
}

function ClientM(x: nat): int {
  if (x <= 19) then LibM(20, 1)
  else LibM(x, 1)
}

// CANDIDATE

const PRIMES1: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

function Lib1(x: nat, b: int): int {
  if b == 0 then 
    0 
  else 
    LibLoop1(x, 0)
}

function LibLoop1(x: nat, i: int): int
  requires 0 <= i
  requires i <= |PRIMES1|
  decreases |PRIMES1| - i
{
  if i == |PRIMES1| then 
    1
  else
    var p := PRIMES1[i];
    if x % p == 0 then
      0
    else
      LibLoop1(x, i + 1)
}

function Client1(x: nat): int {
  if (x <= 19) then Lib1(20, 1)
  else Lib1(x, 1)
}

lemma equivalence(x: nat)
  ensures ClientM(x) == Client1(x)
{}