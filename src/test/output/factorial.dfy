function fact14_1(n :int): int
{if (n <= 1) then 1 else n * fact14_1(n - 1)}function fact14_2(n :int): int
{if (n <= 1) then 1 else if (n == 10) then 3628800 else n * fact14_2(n - 1)}lemma fact14_2Equivalence(n :int)
ensures fact14_1(n) == fact14_2(n)
{{}}