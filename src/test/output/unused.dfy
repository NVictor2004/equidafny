function t1(n: int): int
{if (n < 1) then 0 else if (n == 1) then 1 else t1(n - 1) + t1(n - 2)}

function t2(n: int): int
{if (n < 1) then 0 else if (n == 1 || n == 2) then 1 else var r1 := t2(n - 1);
var r2 := t2(n - 2);
var r3 := t2(n - 3);
var results := if (n % 2 == 0) then r2 + r2 + r3 else r1 + r2;
results}

lemma t2Equivalence(n: int)
ensures t1(n) == t2(n)
{{}}

