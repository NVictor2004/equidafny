function mainM(x: int): int
{if ((x >= 9) && (x < 12)) then fooM(x, 10) else 0}

function main1(x: int): int
{if ((x >= 9) && (x < 12)) then foo1(x, 10) else 0}

function foo1Helper(a: int, b: int, c: int, i: int): int
decreases ((a - i))
{if (i <= a) then foo1Helper(a, b, (c - b), (i + 1)) else c}

function foo1(a: int, b: int): int
{foo1Helper(a, b, 0, 1)}

function fooMHelper(a: int, b: int, c: int, i: int): int
decreases ((b - i))
{if (i <= b) then fooMHelper(a, b, (c + a), (i + 1)) else c}

function fooM(a: int, b: int): int
{fooMHelper(a, b, 0, 1)}

lemma mainM_main1_Equivalence(x: int)
ensures (mainM(x) == main1(x))
{{match ((x >= 9) && (x < 12)) {
case false =>
case true =>fooM_foo1_Equivalence(x, 10);
}
}}

lemma fooMHelper_foo1Helper_Equivalence(a: int, b: int, c: int, i: int)
decreases ((b - i))
ensures (fooMHelper(a, b, c, i) == foo1Helper(b, a, c, i))
{{match (i <= b) {
case false =>
case true =>fooMHelper_foo1Helper_Equivalence(a, b, (c + a), (i + 1));
}
}}

lemma fooM_foo1_Equivalence(a: int, b: int)
ensures (fooM(a, b) == foo1(b, a))
{{fooMHelper_foo1Helper_Equivalence(a, b, 0, 1);}}

