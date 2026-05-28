function fM(z: int): int
{(f_loopM(1) * 2)}

function f1(z: int): int
{(2 * f_loop1(1))}

function f_loop1(x: int): int
requires (x > 0)
decreases ((9 - x))
{if (x <= 9) then var y := (x + 2);
f_loop1((2 * y)) else x}

function f_loopM(x: int): int
requires (x > 0)
decreases ((10 - x))
{if (x < 10) then var y := (2 + x);
f_loopM((y + y)) else x}

lemma fM_f1_Equivalence(z: int)
ensures (fM(z) == f1(z))
{{}}

