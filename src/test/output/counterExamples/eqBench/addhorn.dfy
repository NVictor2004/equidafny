function fM(i: int, j: int): int
requires (i >= 0)
{if (i == 0) then j else fM((i - 1), (j + 1))}

function f1(i: int, j: int): int
requires (i >= 0)
{if (i == 0) then j else if (i == 1) then (j + 1) else if (i == 2) then j else f1((i - 1), (j + 1))}

lemma fM_f1_Equivalence(i: int, j: int)
requires (i >= 0)
ensures (fM(i, j) == f1(i, j))
{{}}

