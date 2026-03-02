/* Copyright 2009-2024 EPFL, Lausanne */



datatype Direction =
    Left
    | Up
    | Diagonal

function valid2DLengthM(a: seq<seq<int>>, w: seq<seq<Direction>>, m: int, n: int, k: int): bool
  requires (|a| == m && |w| == m && |a| > 0 && |w| > 0 && k >= -1 && k < m)
  decreases(k+1) {
  (k == -1) || (|a[k]| == n && |w[k]| == n && valid2DLengthM(a, w, m, n, k - 1))
  }

function valid2DLength(a: seq<seq<int>>, w: seq<seq<Direction>>, m: int, n: int, k: int): bool
  requires (|a| == m && |w| == m && |a| > 0 && |w| > 0 && k >= -1 && k < m)
  decreases(k+1) {
  if (k == -1) then true
  else if (|a[k]| != n) then false
  else if (|w[k]| != n) then false
  else valid2DLength(a, w, m, n, k - 1)
  }