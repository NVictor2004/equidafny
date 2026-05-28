function fM(n: real): real
{f_loopM(n, 0.000000, 0.000000)}

function f1(n: real): real
{f_loop1(n, n, 0.000000)}

function f_loop1(n: real, i: real, j: real): real
{if (i >= 0.000000) then f_loop1(n, (i - 1.000000), (j + 1.000000)) else j}

function f_loopM(n: real, i: real, j: real): real
decreases ((n - i))
{if (i <= n) then f_loopM(n, (i + 1.000000), (j + 1.000000)) else j}

lemma fM_f1_Equivalence(n: real)
ensures (fM(n) == f1(n))
{{f_loopM_f_loop1_Equivalence(n, 0.000000, 0.000000);}}

lemma f_loopM_f_loop1_Equivalence(n: real, i: real, j: real)
decreases ((n - i))
ensures (f_loopM(n, i, j) == f_loop1(n, i, j))
{{match (i <= n) {
case false =>
case true =>f_loopM_f_loop1_Equivalence(n, (i + 1.000000), (j + 1.000000));
}
}}

