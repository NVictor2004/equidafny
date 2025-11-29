/* Copyright 2009-2024 EPFL, Lausanne */



var MAX := 100000;

method arrayContentM(a: seq<int>, n: int)  returns (res: Set[int])
  requires (n >= 0 && n <= a.length && a.length <= MAX)
  decreases(n) {
  if n == 0  Set.empty[int]
  else arrayContentM(a, n-1) ++ Set(a(n-1))


method arrayContent(a: seq<int>, n: int)  returns (res: Set[int])
  requires (n >= 0 && n <= a.length && a.length <= MAX)
  decreases(n) {
  if n == 0  Set.empty[int]
  else Set(a(n-1)) ++ arrayContent(a, n-1)
