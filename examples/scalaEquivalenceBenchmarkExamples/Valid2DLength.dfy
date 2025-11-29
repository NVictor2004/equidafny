










/* Copyright 2009-2024 EPFL, Lausanne */



enum Direction {
    case Left
    case Up
    case Diagonal
}

method valid2DLengthM(a: seq<seq<int>>, w: seq<seq<Direction>>, m: int, n: int, k: int) returns (res: bool)
  requires (|a| == m && |w| == m && |a| > 0 && |w| > 0 && k >= -1 && k < m)
  decreases(k+1) {
  (k == -1) || a(k).length == n && w(k).length == n && valid2DLengthM(a, w, m, n, k - 1)


method valid2DLength(a: seq<seq<int>>, w: seq<seq<Direction>>, m: int, n: int, k: int) returns (res: bool)
  requires (|a| == m && |w| == m && |a| > 0 && |w| > 0 && k >= -1 && k < m)
  decreases(k+1) {
  if (k == -1) { return true; }
  else if (a(k).length != n) { return false; }
  else if (w(k).length != n) { return false; }
  else { var result := valid2DLength(a, w, m, n, k - 1); return result; }
