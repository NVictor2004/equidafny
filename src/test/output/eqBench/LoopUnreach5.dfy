function mainM(x: int): int
{if ((x >= 5) && (x < 7)) then fooM(x, 5) else 0}

function main1(x: int): int
{if ((x >= 5) && (x < 7)) then foo1(x, 5) else 0}

function foo1Helper(a: int, b: int, c: int, i: int): int
decreases ((a - i))
{if (i <= a) then foo1Helper(a, b, (c + b), (i + 1)) else c}

function foo1(a: int, b: int): int
{if (a < 0) then foo1Helper(a, b, 0, 1) else 0}

function fooMHelper(a: int, b: int, c: int, i: int): int
decreases ((b - i))
{if (i <= b) then fooMHelper(a, b, (c + a), (i + 1)) else c}

function fooM(a: int, b: int): int
{if (a < 0) then fooMHelper(a, b, 0, 1) else 0}

lemma mainM_main1_Equivalence(x: int)
ensures (mainM(x) == main1(x))
{{match ((x >= 5) && (x < 7)) {
case false =>
case true =>fooM_foo1_Equivalence(x, 5);
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
{{match (a < 0) {
case false =>
case true =>fooMHelper_foo1Helper_Equivalence(a, b, 0, 1);
}
}}

