// MODEL

// Equivalent to #define NUMPRIMES 8 and the static array
const PRIMESM: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

// The main logic function
function LibM(x: nat, b: int): int {
  if b == 0 then 
    0 
  else 
    LibLoopM(x, 0)
}

// The recursive function implementing the for-loop
function LibLoopM(x: nat, i: int): int
  requires 0 <= i <= |PRIMESM|
  decreases |PRIMESM| - i
{
  if i == |PRIMESM| then 
    1 // Loop finished without returning: return 1
  else
    var p := PRIMESM[i];
    if x % p == 0 then
      0
    else
      LibLoopM(x, i + 1)
}

// The client function
function ClientM(x: nat): int {
  LibM(x, 0)
}

// CANDIDATE

// Equivalent to #define NUMPRIMES 8 and the static array
const PRIMES1: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

// The main logic function
function Lib1(x: nat, b: int): int {
  if b == 0 then 
    0 
  else 
    LibLoop1(x, 0)
}

// The recursive function implementing the for-loop
function LibLoop1(x: nat, i: int): int
  requires 0 <= i <= |PRIMES1|
  decreases |PRIMES1| - i
{
  if i == |PRIMES1| then 
    1 // Loop finished without returning: return 1
  else
    var p := PRIMES1[i];
    if x % p == 0 then
      if x == p then 1 else 0
    else
      LibLoop1(x, i + 1)
}

// The client function
function Client1(x: nat): int {
  Lib1(x, 0)
}