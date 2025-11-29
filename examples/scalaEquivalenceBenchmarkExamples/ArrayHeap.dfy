










/* Copyright 2009-2024 EPFL, Lausanne */


method childrenAreHeapsM(a: seq<int>, N: int, i: int) returns (res: bool)
  requires (i >= 0 && i < N && N <= |a| && N <= 100000) {
  var l := leftM(i);
  var r := rightM(i);
  if (l < N && r < N) 
    { var result := isHeapM(a, N, l); var result2 := isHeapM(a, N, r); return result && result2; }
  else if (l < N) { var result := 
    isHeapM(a, N, l); return result; }
  else
    {return true;}
}

method isHeapM(a: seq<int>, N: int, i: int)  returns (res: bool)
  requires (i >= 0 && i < N && N <= |a| && N <= 100000)
  decreases(N - i) {
  var l := leftM(i);
  var r := rightM(i);
  var isHeapL := isHeapM(a, N, l);
  isHeapL := l < N && isHeapL;
  var isHeapR := isHeapM(a, N, r);
  isHeapR := r < N && isHeapR;
  if (l < N && a[l] > a[i]) { return 
    false; }
  else if (r < N && a[r] > a[i]) { return 
    false; }
  else if (r < i) { return 
    isHeapL && isHeapR; }
  else if (l < i) { return 
    isHeapL; }
  else
    {return true;}
  }

method leftM(i: int)  returns (res: int)
  requires (0 <= i && i < 100000)
  {return 2 * i + 1;}

method rightM(i: int)  returns (res: int)
  requires (0 <= i && i < 100000)
  {return 2 * i + 2;}

method childrenAreHeaps(a: seq<int>, N: int, i: int) returns (res: bool)
  requires (i >= 0 && i < N && N <= |a| && N <= 100000) {
  if (2 * i + 1 < N && 2 * i + 2 < N) 
    { var result1 := isHeap(a, N, 2 * i + 1); var result2 := isHeap(a, N, 2 * i + 2); return result1 && result2; }
  else if (2 * i + 1 < N) { var result := 
    isHeap(a, N, 2 * i + 1); return result; }
  else
    {return true;}
  }

method isHeap(a: seq<int>, N: int, i: int)  returns (res: bool)
  requires (i >= 0 && i < N && N <= |a| && N <= 100000)
  decreases(N - i) {
  var l := 2 * i + 1;
  var r := 2 * i + 2;
  if (2 * i + 1 < N && a[2 * i + 1] > a[i]) { return 
    false; }
  else if (2 * i + 2 < N && a[r] > a[i]) { return 
    false; }
  else if (2 * i + 2 < i) 
    { var result1 := isHeap(a, N, 2 * i + 2); var result2 := isHeap(a, N, 2 * i + 1); return result1 && result2; }
  else if (2 * i + 1 < i) { var result := 
    isHeap(a, N, 2 * i + 1); return result; }
  else
    {return true;}
  }