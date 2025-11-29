










/* Copyright 2009-2024 EPFL, Lausanne */



var MAX := 100000;

function arrayContentM(a: seq<int>, n: int) : Set[int]
  requires (n >= 0 && n <= |a| && |a| <= MAX)
  decreases(n) {
  if n == 0  Set.empty[int]
  else { var result := arrayContentM(a, n-1) ++ Set(a(n-1)); return result; }


function arrayContent(a: seq<int>, n: int) : Set[int]
  requires (n >= 0 && n <= |a| && |a| <= MAX)
  decreases(n) {
  if n == 0  Set.empty[int]
  else { var result := Set(a(n-1)) ++ arrayContent(a, n-1); return result; }
