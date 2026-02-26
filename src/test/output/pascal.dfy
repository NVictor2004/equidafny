function p1(n :int, m :int): int
{if (m < 1 || n < 1 || m > n) then 0 else if (m == 1 || n == 1 || m == n) then 1 else p1(n - 1, m - 1) + p1(n - 1, m)}function p2(n :int, m :int): int
{if (m < 1 || n < 1 || m > n) then 0 else if (m == 1 || n == 1 || m == n) then 1 else p2(n - 1, m - 1) + p2(n - 2, m - 1) + p2(n - 2, m)}lemma p2Equivalence(n :int, m :int)
ensures p1(n, m) == p2(n, m)
{{}}