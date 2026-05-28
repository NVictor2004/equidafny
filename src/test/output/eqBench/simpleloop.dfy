function fM(z: int): int
{f_loopM(0)}

function f1(z: int): int
{f_loop1(1)}

function f_loop1(i: int): int
decreases ((11 - i))
{if (i <= 10) then f_loop1((i + 1)) else i}

function f_loopM(i: int): int
decreases ((11 - i))
{if (i <= 10) then f_loopM((i + 1)) else i}

lemma fM_f1_Equivalence(z: int)
ensures (fM(z) == f1(z))
{{f_loopM_f_loop1_Equivalence(0);}}

lemma f_loopM_f_loop1_Equivalence(i: int)
decreases ((11 - i))
ensures (f_loopM(i) == f_loop1(i))
{{match (i <= 10) {
case false =>
case true =>f_loopM_f_loop1_Equivalence((i + 1));
}
}}

