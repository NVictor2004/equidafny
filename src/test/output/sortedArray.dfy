function isSortedArrayM(a: seq<int>, start: int, n: int): bool
decreases (n)
requires (((0 <= start) && (n >= start)) && (n <= |a|))
{((n <= succM(start)) || (!(a[(n - 2)] > a[(n - 1)]) && isSortedArrayM(a, start, (n - 1))))}

function isSortedArray(a: seq<int>, start: int, n: int): bool
decreases (n)
requires (((0 <= start) && (n >= start)) && (n <= |a|))
{((n == start) || ((n == (start + 1)) || (!(a[(n - 2)] > a[(n - 1)]) && isSortedArray(a, start, (n - 1)))))}

function succM(n: int): int
{(n + 1)}

lemma isSortedArrayM_isSortedArray_Equivalence(a: seq<int>, start: int, n: int)
decreases (n)
requires (((0 <= start) && (n >= start)) && (n <= |a|))
ensures (isSortedArrayM(a, start, n) == isSortedArray(a, start, n))
{{}}

