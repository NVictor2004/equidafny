function mainM(): int
{fooM(5, 900)}

function main1(): int
{foo1(5, 900)}

function foo1(a: int, b: int): int
{var d := 3;
var c := (b + a);
(c + d)}

function fooM(a: int, b: int): int
{var c := (a + b);
(c + 3)}

lemma mainM_main1_Equivalence()
ensures (mainM() == main1())
{{fooM_foo1_Equivalence(5, 900);}}

lemma fooM_foo1_Equivalence(a: int, b: int)
ensures (fooM(a, b) == foo1(a, b))
{{}}

