










/* Copyright 2009-2024 EPFL, Lausanne */



function validLengthIncreasingM(a:seq<seq<int>>, N:int, M:int, k: int): bool
  requires (N > 0 && N == |a| && M > 0 && k >= 0 && k <= N)
  decreases(N - k) {
  if (k == N) { return 
    true; }
  else
    {var result := validLengthIncreasingM(a, N, M, succM(k)); return |a[k]| == M && result; }
  }
function succM(n: int): int
 {
  n + 1
}


function validLengthIncreasing(a:seq<seq<int>>, N:int, M:int, k: int): bool
  requires (N > 0 && N == |a| && M > 0 && k >= 0 && k <= N)
  decreases(N - k) {
  if (k == N) { return 
    true; }
  var result := validLengthIncreasing(a, N, M, k + 1);
  return |a[k]| == M && result;
  }
