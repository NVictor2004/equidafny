

































/* Copyright 2009-2024 EPFL, Lausanne */



enum Direction {
    case Left
    case Up
    case Diagonal
}

function valid2DLengthM(a: seq<seq<int>>, w: seq<seq<Direction>>, m: int, n: int, k: int): bool
  requires (|a| == m && |w| == m && |a| > 0 && |w| > 0 && k >= -1 && k < m)
  decreases(k+1) {
  (k == -1) || a(k).length == n && w(k).length == n && valid2DLengthM(a, w, m, n, k - 1)


function valid2DLength(a: seq<seq<int>>, w: seq<seq<Direction>>, m: int, n: int, k: int): bool
  requires (|a| == m && |w| == m && |a| > 0 && |w| > 0 && k >= -1 && k < m)
  decreases(k+1) {
  if (k == -1) then true
  else if (a(k).length != n) then false
  else if (w(k).length != n) then false
  else valid2DLength(a, w, m, n, k - 1)
