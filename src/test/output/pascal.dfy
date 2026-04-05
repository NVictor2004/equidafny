function p1(n: int, m: int): int
{if if if (m < 1) then true else (n < 1) then true else (m > n) then 0 else if if if (m == 1) then true else (n == 1) then true else (m == n) then 1 else (p1((n - 1), (m - 1)) + p1((n - 1), m))}

function p2(n: int, m: int): int
{if if if (m < 1) then true else (n < 1) then true else (m > n) then 0 else if if if (m == 1) then true else (n == 1) then true else (m == n) then 1 else ((p2((n - 1), (m - 1)) + p2((n - 2), (m - 1))) + p2((n - 2), m))}

lemma p1_p2_Equivalence(n: int, m: int)
ensures (p1(n, m) == p2(n, m))
{{if if if (m < 1) then true else (n < 1) then true else (m > n){}else {if if if (m == 1) then true else (n == 1) then true else (m == n){}else {p1_p2_Equivalence((n - 1), m);}}}}

