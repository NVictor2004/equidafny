function fM(n: int): int
{f_loopM(n, 1)}

function f1(n: int): int
{f_loop1((n / 10), 1)}

function f_loop1(n: int, result: int): int
{if (n <= 0) then result else var n1 := (n / 10);
var r1 := (result + 1);
if (n1 <= 0) then f_loop1(n1, r1) else var n2 := (n1 / 10);
var r2 := (r1 + 1);
if (n2 <= 0) then f_loop1(n2, r2) else var n3 := (n2 / 10);
var r3 := (r2 + 1);
if (n3 <= 0) then f_loop1(n3, r3) else f_loop1((n3 / 10), (r3 + 1))}

function f_loopM(n: int, result: int): int
{if (n < 10) then result else if (n < 100) then (result + 1) else if (n < 1000) then (result + 2) else if (n < 10000) then (result + 3) else f_loopM((n / 10000), (result + 4))}

lemma fM_f1_Equivalence(n: int)
ensures (fM(n) == f1(n))
{{f_loopM_f_loop1_Equivalence(n, 1);}}

lemma f_loopM_f_loop1_Equivalence(n: int, result: int)
ensures (f_loopM(n, result) == f_loop1(n, result))
{{match (n < 10) {
case false =>match (n < 100) {
case false =>match (n < 1000) {
case false =>match (n < 10000) {
case false =>f_loopM_f_loop1_Equivalence((n / 10000), (result + 4));
case true =>
}

case true =>
}

case true =>
}

case true =>
}
}}

