










/* Copyright 2009-2024 EPFL, Lausanne */



var MAX := 100000;

method childrenAreHeapsM(a: seq<int>, N: int, i: int) returns (res: bool)
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  var l := leftM(i);
  var r := rightM(i);
  if (l < N && r < N) 
    isHeapM(a, N, l) { var result := && isHeapM(a, N, r); return result; }
  else if (l < N) { var result := 
    isHeapM(a, N, l); return result; }
  else
    true

method isHeapM(a: seq<int>, N: int, i: int)  returns (res: bool)
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  decreases(N - i) {
  var l := leftM(i);
  var r := rightM(i);
  var isHeapL := l < N && isHeapM(a, N, l);
  var isHeapR := r < N && isHeapM(a, N, r);
  if (l < N && a(l) > a(i)) { return 
    false; }
  else if (r < N && a(r) > a(i)) { return 
    false; }
  else if (r < i) { return 
    isHeapL && isHeapR; }
  else if (l < i) { return 
    isHeapL; }
  else
    true


method leftM(i: int)  returns (res: int)
  requires (0 <= i && i < MAX)
  2 * i + 1

method rightM(i: int)  returns (res: int)
  requires (0 <= i && i < MAX)
  2 * i + 2


method childrenAreHeaps(a: seq<int>, N: int, i: int) returns (res: bool)
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  if (2 * i + 1 < N && 2 * i + 2 < N) 
    isHeap(a, N, 2 * i + 1) { var result := && isHeap(a, N, 2 * i + 2); return result; }
  else if (2 * i + 1 < N) { var result := 
    isHeap(a, N, 2 * i + 1); return result; }
  else
    true

method isHeap(a: seq<int>, N: int, i: int)  returns (res: bool)
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  decreases(N - i) {
  var l := 2 * i + 1;
  var r := 2 * i + 2;
  if (2 * i + 1 < N && a(2 * i + 1) > a(i)) { return 
    false; }
  else if (2 * i + 2 < N && a(r) > a(i)) { return 
    false; }
  else if (2 * i + 2 < i) 
    isHeap(a, N, 2 * i + 2) { var result := && isHeap(a, N, 2 * i + 1); return result; }
  else if (2 * i + 1 < i) { var result := 
    isHeap(a, N, 2 * i + 1); return result; }
  else
    true
