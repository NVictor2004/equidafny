function fM(t: int, c: int): int
{if (0 < t) then f_loopM(c, 0) else 0}

function f1(t: int, c: int): int
requires (t > 0)
{f_loop1(t, c, 0)}

function f_loop1(t: int, c: int, x: int): int
requires (t > 0)
{if (0 < c) then if (0 < t) then f_loop1(t, (c - 1), (x + 1)) else f_loop1(t, c, x) else x}

function f_loopM(c: int, x: int): int
{if (0 < c) then f_loopM((c - 1), (x + 1)) else x}

lemma fM_f1_Equivalence(t: int, c: int)
ensures (fM(t, c) == f1(t, c))
{{}}

