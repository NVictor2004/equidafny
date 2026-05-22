// MODEL

/* Copyright 2022 EPFL, Lausanne */
// source: epfl softcon 2023

function gcdM2(a: int, b: int): int
  requires (a >= 0 && b >= 0)
  decreases(a/2 + b/2 + (if (b-a >=2) then (b-a)/2 else if (b-a >= 0) then (b-a+2)/2 else 0))
  {
  if b == 0 then
    a
  else
    gcdM2(b, a%b)
  }

// CANDIDATE

// The decreases clause needed to be added here
function gcdC(a: int, b: int): int
  requires(a >= 0 && b >= 0)
  decreases b
{
  if b == 0 then a
  else if a < b then gcdC(b,a)
  else gcdC(b, a % b)
}

lemma equivalenceGCDM2C(a: int, b: int)
  requires(a >= 0 && b >= 0)
  ensures gcdM2(a, b) == gcdC(a, b)
  decreases(a/2 + b/2 + (if (b-a >=2) then (b-a)/2 else if (b-a >= 0) then (b-a+2)/2 else 0))
{}