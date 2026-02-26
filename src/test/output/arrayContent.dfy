function arrayContentM(a: seq<int>, n: int): set<int>
requires (n >= 0 && n <= |a| && |a| <= 100000)
decreases (n)
{if n == 0 then {} else arrayContentM(a, n - 1) + {a[n - 1]}}

function arrayContent(a: seq<int>, n: int): set<int>
requires (n >= 0 && n <= |a| && |a| <= 100000)
decreases (n)
{if n == 0 then {} else {a[n - 1]} + arrayContent(a, n - 1)}

lemma arrayContentEquivalence(a: seq<int>, n: int)
requires (n >= 0 && n <= |a| && |a| <= 100000)
decreases (n)
ensures arrayContentM(a, n) == arrayContent(a, n)
{{}}

