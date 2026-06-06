function fM(n: int): int
{if (n <= 1) then n else var r := fM((n - 1));
(n + r)}

function f1(n: int): int
{if (n <= 1) then n else var r := f1((n - 2));
((n + (n - 1)) + r)}

lemma fM_f1_Equivalence(n: int)
ensures (fM(n) == f1(n))
{{}}

