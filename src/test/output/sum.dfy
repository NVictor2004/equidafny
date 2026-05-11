function sum1(n: int): int
{if (n <= 1) then n else (((n + n) - 1) + sum1((n - 2)))}

function sum2(n: int): int
{if (n <= 1) then n else (n + sum2((n - 1)))}

lemma sum1_sum2_Equivalence(n: int)
ensures (sum1(n) == sum2(n))
{{if (n <= 1){}else {sum1_sum2_Equivalence((n - 2));}}}

