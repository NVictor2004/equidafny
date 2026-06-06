function triangleM(n: int): int
{gM(n)}

function triangle1(n: int): int
{g1(n, 0)}

function g1(n: int, s: int): int
{if (n <= 0) then s else g1((n - 1), (n + s))}

function gM(n: int): int
{if (n <= 0) then 0 else var r := gM((n - 1));
(n + r)}

lemma triangleM_triangle1_Equivalence(n: int)
ensures (triangleM(n) == triangle1(n))
{{}}

