function gcdM2(a: int, b: int): int
requires ((a >= 0) && (b >= 0))
decreases ((((a / 2) + (b / 2)) + if ((b - a) >= 2) then ((b - a) / 2) else if ((b - a) >= 0) then (((b - a) + 2) / 2) else 0))
{if (b == 0) then a else gcdM2(b, (a % b))}

function gcdC(a: int, b: int): int
requires ((a >= 0) && (b >= 0))
decreases (b)
{if (b == 0) then a else if (a < b) then gcdC(b, a) else gcdC(b, (a % b))}

lemma gcdM2_gcdC_Equivalence(a: int, b: int)
requires ((a >= 0) && (b >= 0))
decreases ((((a / 2) + (b / 2)) + if ((b - a) >= 2) then ((b - a) / 2) else if ((b - a) >= 0) then (((b - a) + 2) / 2) else 0))
ensures (gcdM2(a, b) == gcdC(a, b))
{{}}

