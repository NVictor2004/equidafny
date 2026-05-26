/* Copyright 2022 EPFL, Lausanne */

import stainless.lang._

// source: epfl softcon 2023

object GCD:

  def gcdM1(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    decreases(a, b)
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

  def gcdM2(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    decreases(a/2 + b/2 + (if(b-a >=2) (b-a)/2 else if(b-a >= 0) (b-a+2)/2 else 0))
    if b == 0 then
      a
    else
      gcdM2(b, a%b)