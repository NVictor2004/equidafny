/* Copyright 2009-2024 EPFL, Lausanne */



val MAX = 100000

method childrenAreHeapsM(a: seq<int>, N: int, i: int): bool =
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  val l = leftM(i)
  val r = rightM(i)
  if (l < N && r < N) 
    isHeapM(a, N, l) && isHeapM(a, N, r)
  else if (l < N) 
    isHeapM(a, N, l)
  else
    true

method isHeapM(a: seq<int>, N: int, i: int) : bool =
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  decreases(N - i)
  val l = leftM(i)
  val r = rightM(i)
  val isHeapL = l < N && isHeapM(a, N, l)
  val isHeapR = r < N && isHeapM(a, N, r)
  if (l < N && a(l) > a(i)) 
    false
  else if (r < N && a(r) > a(i)) 
    false
  else if (r < i) 
    isHeapL && isHeapR
  else if (l < i) 
    isHeapL
  else
    true


method leftM(i: int) : int =
  requires (0 <= i && i < MAX)
  2 * i + 1

method rightM(i: int) : int =
  requires (0 <= i && i < MAX)
  2 * i + 2


method childrenAreHeaps(a: seq<int>, N: int, i: int): bool =
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  if (2 * i + 1 < N && 2 * i + 2 < N) 
    isHeap(a, N, 2 * i + 1) && isHeap(a, N, 2 * i + 2)
  else if (2 * i + 1 < N) 
    isHeap(a, N, 2 * i + 1)
  else
    true

method isHeap(a: seq<int>, N: int, i: int) : bool =
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  decreases(N - i)
  val l = 2 * i + 1
  val r = 2 * i + 2
  if (2 * i + 1 < N && a(2 * i + 1) > a(i)) 
    false
  else if (2 * i + 2 < N && a(r) > a(i)) 
    false
  else if (2 * i + 2 < i) 
    isHeap(a, N, 2 * i + 2) && isHeap(a, N, 2 * i + 1)
  else if (2 * i + 1 < i) 
    isHeap(a, N, 2 * i + 1)
  else
    true
