function validLengthIncreasingM(a: seq<seq<int>>, N: int, M: int, k: int): bool
requires (N > 0 && N == |a| && M > 0 && k >= 0 && k <= N)
decreases (N - k)
{if (k == N) then true else |a[k]| == M && validLengthIncreasingM(a, N, M, succM(k))}

function validLengthIncreasing(a: seq<seq<int>>, N: int, M: int, k: int): bool
requires (N > 0 && N == |a| && M > 0 && k >= 0 && k <= N)
decreases (N - k)
{if (k == N) then true else |a[k]| == M && validLengthIncreasing(a, N, M, k + 1)}

function succM(n: int): int
{n + 1}

lemma validLengthIncreasingM_validLengthIncreasing_Equivalence(a: seq<seq<int>>, N: int, M: int, k: int)
requires (N > 0 && N == |a| && M > 0 && k >= 0 && k <= N)
decreases (N - k)
ensures validLengthIncreasingM(a, N, M, k) == validLengthIncreasing(a, N, M, k)
{{}}

