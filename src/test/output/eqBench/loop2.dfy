function fM(n: int): int
{f_loopM(n, 1, 0)}

function f1(n: int): int
{f_loop1(n, 0, 0)}

function f_loop1(n: int, i: int, j: int): int
decreases ((n - i))
{if (i < n) then f_loop1(n, (i + 1), (j + 2)) else j}

function f_loopM(n: int, i: int, j: int): int
decreases ((n - i))
{if (i <= n) then f_loopM(n, (i + 1), (j + 2)) else j}

lemma fM_f1_Equivalence(n: int)
ensures (fM(n) == f1(n))
{{f_loopM_f_loop1_Equivalence(n, 1, 0);}}

lemma f_loopM_f_loop1_Equivalence(n: int, i: int, j: int)
decreases ((n - i))
ensures (f_loopM(n, i, j) == f_loop1(n, i, j))
{{match (i <= n) {
case false =>
case true =>f_loopM_f_loop1_Equivalence(n, (i + 1), (j + 2));
}
}}

