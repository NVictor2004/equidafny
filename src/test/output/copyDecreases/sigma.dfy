function solution_2(f: int -> int, a: int, b: int): int
decreases (if (b == a) then 2 else if (b > a) then ((2 + b) - a) else (a - b))
{if (a > b) then 0 else if (a == b) then f(a) else (f(b) + solution_2(f, a, (b - 1)))}

function sigmaC(f: int -> int, a: int, b: int): int
decreases ((b - a))
{if (a > b) then 0 else (f(a) + sigmaC(f, (a + 1), b))}

lemma solution_2_sigmaC_Equivalence(f: int -> int, a: int, b: int)
decreases (if (b == a) then 2 else if (b > a) then ((2 + b) - a) else (a - b))
ensures (solution_2(f, a, b) == sigmaC(f, a, b))
{{}}

