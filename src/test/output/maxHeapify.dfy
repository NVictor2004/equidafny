function maxHeapifyM(a: seq<int>, N: int, i: int): seq<int>
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
decreases (N - i)
{var l := leftM(i);
var r := rightM(i);
var largest := if l < N && a[l] > a[i] then l else i;
var largest2 := if r < N && a[r] > a[largest] then r else largest;
if (largest2 != i) then var temp := a[i];
maxHeapifyM(a[i := a[largest2]][largest2 := temp], N, largest2) else a}

function maxHeapify(a: seq<int>, N: int, i: int): seq<int>
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
decreases (N - i)
{var l := 2 * i + 1;
var r := 2 * i + 2;
var largest := if l < N && a[l] > a[i] then l else i;
var largest2 := if r < N && a[r] > a[largest] then r else largest;
if (largest2 != i) then var newArr := swap(i, largest2, a, N);
maxHeapify(newArr, N, largest2) else a}

function swap(a: int, b: int, arr: seq<int>, N: int): seq<int>
requires (a >= 0 && a < N && b >= 0 && b < N && N <= |arr| && N <= 100000)
{var temp := arr[a];
arr[a := arr[b]][b := temp]}

function rightM(i: int): int
requires (0 <= i && i < 100000)
{2 * i + 2}

function leftM(i: int): int
requires (0 <= i && i < 100000)
{2 * i + 1}

lemma maxHeapifyM_maxHeapify_Equivalence(a: seq<int>, N: int, i: int)
requires (i >= 0 && i < N && N <= |a| && N <= 100000)
decreases (N - i)
ensures maxHeapifyM(a, N, i) == maxHeapify(a, N, i)
{{var l := leftM(i);var r := rightM(i);var largest := if l < N && a[l] > a[i] then l else i;var largest2 := if r < N && a[r] > a[largest] then r else largest;if (largest2 != i){var temp := a[i];}else {}}}

