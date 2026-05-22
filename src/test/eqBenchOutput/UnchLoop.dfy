function FooM(a: int, b: int): int
{(FooLoopM(a, b, 0, 0) + 1)}

function Foo1(a: int, b: int): int
{FooLoop1(a, b, 0, 1)}

function FooLoop1(a: int, b: int, i: int, c: int): int
decreases ((a - i))
{if (i < a) then FooLoop1(a, b, (i + 1), (c + b)) else c}

function FooLoopM(a: int, b: int, i: int, c: int): int
decreases ((a - i))
{if (i < a) then FooLoopM(a, b, (i + 1), (c + b)) else c}

lemma FooM_Foo1_Equivalence(a: int, b: int)
ensures (FooM(a, b) == Foo1(a, b))
{{}}

