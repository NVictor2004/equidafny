function fM(n: int): int
{f_loopM(n, 0, 0)}

function f1(n: int): int
{f_loop1(n, 1, 0)}

function f_loop1(n: int, j: int, x: int): int
decreases ((n - j))
{if (j <= n) then f_loop1(n, (j + 1), (x + j)) else x}

function f_loopM(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then f_loopM(n, (i + 1), (x + i)) else x}

lemma fM_f1_Equivalence(n: int)
ensures (fM(n) == f1(n))
{{f_loopM_f_loop1_Equivalence(n, 0, 0);}}

lemma f_loopM_f_loop1_Equivalence(n: int, i: int, x: int)
decreases ((n - i))
ensures (f_loopM(n, i, x) == f_loop1(n, i, x))
{{match (i <= n) {
case false =>
case true =>f_loopM_f_loop1_Equivalence(n, (i + 1), (x + i));
}
}}

