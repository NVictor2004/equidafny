function childrenAreHeapsM(a: seq<int>, N: int, i: int): bool
requires ((((i >= 0) && (i < N)) && (N <= |a|)) && (N <= 100000))
{var l := leftM(i);
var r := rightM(i);
if ((l < N) && (r < N)) then (isHeapM(a, N, l) && isHeapM(a, N, r)) else (!(l < N) || isHeapM(a, N, l))}

function childrenAreHeaps(a: seq<int>, N: int, i: int): bool
requires ((((i >= 0) && (i < N)) && (N <= |a|)) && (N <= 100000))
{if ((((2 * i) + 1) < N) && (((2 * i) + 2) < N)) then (isHeap(a, N, ((2 * i) + 1)) && isHeap(a, N, ((2 * i) + 2))) else (!(((2 * i) + 1) < N) || isHeap(a, N, ((2 * i) + 1)))}

function isHeap(a: seq<int>, N: int, i: int): bool
requires ((((i >= 0) && (i < N)) && (N <= |a|)) && (N <= 100000))
decreases ((N - i))
{var l := ((2 * i) + 1);
var r := ((2 * i) + 2);
(!((((2 * i) + 1) < N) && (a[((2 * i) + 1)] > a[i])) && (!((((2 * i) + 2) < N) && (a[r] > a[i])) && if (((2 * i) + 2) < i) then (isHeap(a, N, ((2 * i) + 2)) && isHeap(a, N, ((2 * i) + 1))) else (!(((2 * i) + 1) < i) || isHeap(a, N, ((2 * i) + 1)))))}

function rightM(i: int): int
requires ((0 <= i) && (i < 100000))
{((2 * i) + 2)}

function leftM(i: int): int
requires ((0 <= i) && (i < 100000))
{((2 * i) + 1)}

function isHeapM(a: seq<int>, N: int, i: int): bool
requires ((((i >= 0) && (i < N)) && (N <= |a|)) && (N <= 100000))
decreases ((N - i))
{var l := leftM(i);
var r := rightM(i);
var isHeapL := ((l < N) && isHeapM(a, N, l));
var isHeapR := ((r < N) && isHeapM(a, N, r));
(!((l < N) && (a[l] > a[i])) && (!((r < N) && (a[r] > a[i])) && if (r < i) then (isHeapL && isHeapR) else (!(l < i) || isHeapL)))}

lemma childrenAreHeapsM_childrenAreHeaps_Equivalence(a: seq<int>, N: int, i: int)
requires ((((i >= 0) && (i < N)) && (N <= |a|)) && (N <= 100000))
ensures (childrenAreHeapsM(a, N, i) == childrenAreHeaps(a, N, i))
{{var l := leftM(i);var r := rightM(i);if ((l < N) && (r < N)){isHeapM_isHeap_Equivalence(a, N, l);isHeapM_isHeap_Equivalence(a, N, r);}else {isHeapM_isHeap_Equivalence(a, N, l);}}}

lemma isHeapM_isHeap_Equivalence(a: seq<int>, N: int, i: int)
requires ((((i >= 0) && (i < N)) && (N <= |a|)) && (N <= 100000))
decreases ((N - i))
ensures (isHeapM(a, N, i) == isHeap(a, N, i))
{{}}

