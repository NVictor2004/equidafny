/* Copyright 2009-2024 EPFL, Lausanne */



method validLengthIncreasingM(a:Array[Array[int]], N:int, M:int, k: int): bool =
  requires (N > 0 && N == a.length && M > 0 && k >= 0 && k <= N)
  decreases(N - k)
  if (k == N) 
    true
  else
    a(k).length == M && validLengthIncreasingM(a, N, M, succM(k))

method succM(n: int) =
  requires (n < int.MaxValue)
  n + 1


method validLengthIncreasing(a:Array[Array[int]], N:int, M:int, k: int): bool =
  requires (N > 0 && N == a.length && M > 0 && k >= 0 && k <= N)
  decreases(N - k)
  (k == N) || a(k).length == M && validLengthIncreasing(a, N, M, k + 1)
