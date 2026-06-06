function fM(a: int): int
ensures ((a <= 100) ==> (fM(a) == 91))
decreases ((111 - a))
{if (a > 100) then (a - 10) else var r := fM((a + 11));
fM(r)}

function f1(x: int): int
ensures ((x <= 100) ==> (f1(x) == 91))
decreases ((111 - x))
{if (x < 101) then var r := f1((11 + x));
f1(r) else (x - 10)}

lemma fM_f1_Equivalence(a: int)
ensures ((a <= 100) ==> (fM(a) == 91))
decreases ((111 - a))
ensures (fM(a) == f1(a))
{{}}

