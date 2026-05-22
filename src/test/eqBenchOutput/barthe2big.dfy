function fM(n: int): int
{var x_after_first_loop := f_loop1M(n, 1, 1);
f_loop2M(n, 0, x_after_first_loop)}

function f1(n: int): int
{var x1 := PowerLoop1(n, 1, 1);
SumLoop1(n, 1, x1)}

function SumLoop1(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then SumLoop1(n, (i + 1), (x + i)) else x}

function PowerLoop1(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then PowerLoop1(n, (i + 1), (x * 5)) else x}

function f_loop2M(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then f_loop2M(n, (i + 1), (x + i)) else x}

function f_loop1M(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then f_loop1M(n, (i + 1), (x * 5)) else x}

lemma fM_f1_Equivalence(n: int)
ensures (fM(n) == f1(n))
{{var x_after_first_loop := f_loop1M(n, 1, 1);f_loop2M_SumLoop1_Equivalence(n, 0, x_after_first_loop);}}

lemma f_loop2M_SumLoop1_Equivalence(n: int, i: int, x: int)
decreases ((n - i))
ensures (f_loop2M(n, i, x) == SumLoop1(n, i, x))
{{match (i <= n) {
case false =>
case true =>f_loop2M_SumLoop1_Equivalence(n, (i + 1), (x + i));
}
}}

