function limit2_1(n: int): int
{if (n <= 0) then n else n + limit2_1(n - 1)}

function limit2_2(n: int): int
{if (n <= 1) then n else n + limit2_2(n - 1)}

lemma limit2_1_limit2_2_Equivalence(n: int)
ensures limit2_1(n) == limit2_2(n)
{{}}

