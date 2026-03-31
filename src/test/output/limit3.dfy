function limit3_1(n: int): int
{if (n <= 1) then n else n + limit3_1(n - 1)}

function limit3_2(n: int): int
{if (n <= 1) then n else var r := limit3_2(n - 1);
if (r >= 0) then n + r else r}

lemma limit3_1_limit3_2_Equivalence(n: int)
ensures limit3_1(n) == limit3_2(n)
{{}}

