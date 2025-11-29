

































/* Copyright 2009-2024 EPFL, Lausanne */


function arrayContentM(a: seq<int>, n: int) : Set[int]
  requires (n >= 0 && n <= |a| && |a| <= 100000)
  decreases(n) {
  if n == 0  Set.empty[int]
  else arrayContentM(a, n-1) ++ Set(a(n-1))


function arrayContent(a: seq<int>, n: int) : Set[int]
  requires (n >= 0 && n <= |a| && |a| <= 100000)
  decreases(n) {
  if n == 0  Set.empty[int]
  else Set(a(n-1)) ++ arrayContent(a, n-1)
