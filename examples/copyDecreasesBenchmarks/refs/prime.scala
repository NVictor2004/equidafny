package s12

/* Copyright 2022 EPFL, Lausanne */

import stainless.lang._

// ./stainless ../evaluation/Prime.scala --timeout=2 --solvers=smt-z3 --equivchk=true --models=isPrimeM --comparefuns=isPrime  --vc-cache=false
// source: epfl softcon 2023

object Prime:

  def isqrtM(n: BigInt): BigInt =
    require(n >= 0)
    def recM(n: BigInt, i: BigInt): BigInt =
      require(n >= 0 && i > 0 && i-1 <= n)
      decreases(n-i+1)
      if i == n / i then i
      else if i > n / i then i - 1
      else recM(n, i+1)
    recM(n, 1)

  def isPrimeM1(n: BigInt): Boolean =
    require(n >= 0)
    def innerM1(k: BigInt, ref: BigInt): Boolean =
      require(k > 0 && ref > 0 && ref <= k)
      decreases(k-ref)
      if ref > Prime.isqrtM(k) then
        true
      else
        if k%ref == 0 then
          false
        else
          innerM1(k, ref+1)
    if n <= 1 then
      false
    else
      innerM1(n, 2)

  def isPrimeM2(n: BigInt): Boolean =
    require(n >= 0)
    def innterM2(n: BigInt, i: BigInt): Boolean =
      require(n >= 0 && i > 1 && i <= n)
      decreases(n-i)
      if (i >= n) then true
      else if (n % i == 0) then false
      else innterM2(n, i + 1)

    if (n == 0 || n == 1) then
      false
    else
      innterM2(n, 2)