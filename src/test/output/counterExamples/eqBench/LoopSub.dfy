function FooM(a: int, b: int): int
{FooLoopM(b, 0, a)}

function Foo1(a: int, b: int): int
{FooLoop1(a, 0, b)}

function FooLoop1(a: int, i: int, c: int): int
decreases ((3 - i))
{if (i < 2) then FooLoop1(a, (i + 1), (c - a)) else c}

function FooLoopM(b: int, i: int, c: int): int
decreases ((3 - i))
{if (i < 3) then FooLoopM(b, (i + 1), (c - b)) else c}

lemma FooM_Foo1_Equivalence(a: int, b: int)
ensures (FooM(a, b) == Foo1(b, a))
{{FooLoopM_FooLoop1_Equivalence(b, 0, a);}}

lemma FooLoopM_FooLoop1_Equivalence(b: int, i: int, c: int)
decreases ((3 - i))
ensures (FooLoopM(b, i, c) == FooLoop1(b, i, c))
{{match (i < 3) {
case false =>
case true =>FooLoopM_FooLoop1_Equivalence(b, (i + 1), (c - b));
}
}}

