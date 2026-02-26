function isSortedArrayM(a: seq<int>, start: int, n: int): bool
decreases (n)
requires (0 <= start && n >= start && n <= |a|)
{if n <= succM(start) then true else if a[n - 2] > a[n - 1] then false else isSortedArrayM(a, start, n - 1)}

function isSortedArray(a: seq<int>, start: int, n: int): bool
decreases (n)
requires (0 <= start && n >= start && n <= |a|)
{if n == start then true else if n == start + 1 then true else if a[n - 2] > a[n - 1] then false else isSortedArray(a, start, n - 1)}

function succM(n: int): int
{n + 1}

lemma isSortedArrayEquivalence(a: seq<int>, start: int, n: int)
decreases (n)
requires (0 <= start && n >= start && n <= |a|)
ensures isSortedArrayM(a, start, n) == isSortedArray(a, start, n)
{{}}

