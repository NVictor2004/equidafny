function h1(n :int): int
{if (n < 1) then 0 else if (n == 1) then 1 else h1(n - 1) + h1(n - 2)}function h2(n :int): int
{if (n < 1) then 0 else if (n == 1) then 1 else if ((n % 2) == 0) then h2(n - 1) + h2(n - 2) else h2(n - 2) + h2(n - 2) + h2(n - 3)}lemma h2Equivalence(n :int)
ensures h1(n) == h2(n)
{{}}