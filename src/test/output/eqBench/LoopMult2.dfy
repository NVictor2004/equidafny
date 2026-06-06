function mainM(): int
{fooM(2, 2)}

function main1(): int
{foo1(2, 2)}

function foo1Helper(a: int, b: int, c: int, i: int): int
decreases ((a - i))
{if (i <= a) then foo1Helper(a, b, (c + b), (i + 1)) else c}

function foo1(a: int, b: int): int
{foo1Helper(a, b, 0, 1)}

function fooMHelper(a: int, b: int, c: int, i: int): int
decreases ((b - i))
{if (i <= b) then fooMHelper(a, b, (c + a), (i + 1)) else c}

function fooM(a: int, b: int): int
{fooMHelper(a, b, 0, 1)}

lemma mainM_main1_Equivalence()
ensures (mainM() == main1())
{{fooM_foo1_Equivalence(2, 2);}}

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

