function f1(n: int): int
{if (n < 1) then 0 else if (n <= 2) then 1 else (f1((n - 1)) + f1((n - 2)))}

function f2(n: int): int
{if (n < 1) then 0 else if (n <= 2) then 1 else ((f2((n - 2)) + f2((n - 2))) + f2((n - 3)))}

lemma f1_f2_Equivalence(n: int)
ensures (f1(n) == f2(n))
{{}}

