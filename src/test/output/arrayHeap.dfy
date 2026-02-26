function childrenAreHeapsM(a: seq<int>, N: int, i: int): bool
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
{var l := leftM(i);
var r := rightM(i);
if (l < N && r < N) then isHeapM(a, N, l) && isHeapM(a, N, r) else if (l < N) then isHeapM(a, N, l) else true}

function childrenAreHeaps(a: seq<int>, N: int, i: int): bool
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
{if (2 * i + 1 < N && 2 * i + 2 < N) then isHeap(a, N, 2 * i + 1) && isHeap(a, N, 2 * i + 2) else if (2 * i + 1 < N) then isHeap(a, N, 2 * i + 1) else true}

function isHeap(a: seq<int>, N: int, i: int): bool
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
decreases (N - i)
{var l := 2 * i + 1;
var r := 2 * i + 2;
if (2 * i + 1 < N && a[2 * i + 1] > a[i]) then false else if (2 * i + 2 < N && a[r] > a[i]) then false else if (2 * i + 2 < i) then isHeap(a, N, 2 * i + 2) && isHeap(a, N, 2 * i + 1) else if (2 * i + 1 < i) then isHeap(a, N, 2 * i + 1) else true}

function rightM(i: int): int
requires (0 <= i && i < 100000)
{2 * i + 2}

function leftM(i: int): int
requires (0 <= i && i < 100000)
{2 * i + 1}

function isHeapM(a: seq<int>, N: int, i: int): bool
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
decreases (N - i)
{var l := leftM(i);
var r := rightM(i);
var isHeapL := l < N && isHeapM(a, N, l);
var isHeapR := r < N && isHeapM(a, N, r);
if (l < N && a[l] > a[i]) then false else if (r < N && a[r] > a[i]) then false else if (r < i) then isHeapL && isHeapR else if (l < i) then isHeapL else true}

lemma childrenAreHeapsEquivalence(a: seq<int>, N: int, i: int)
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
ensures childrenAreHeapsM(a, N, i) == childrenAreHeaps(a, N, i)
{{}}

