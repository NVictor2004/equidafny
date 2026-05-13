/* Copyright 2022 EPFL, Lausanne */
// source: epfl softcon 2023

function gcdM1(a: int, b: int): int
  requires (a >= 0 && b >= 0)
  decreases a, b
{
  if a == b then 
    a
  else
    if a > b then 
      if b == 0 then 
        a
      else
        gcdM1(a - b, b)
    else
      if a == 0 then
        b
      else
        gcdM1(a, b - a)
}

function gcdM2(a: int, b: int): int
  requires (a >= 0 && b >= 0)
  decreases(a/2 + b/2 + (if (b-a >=2) then (b-a)/2 else if (b-a >= 0) then (b-a+2)/2 else 0))
  {
  if b == 0 then
    a
  else
    gcdM2(b, a%b)
  }