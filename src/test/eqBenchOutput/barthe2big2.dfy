function fM(n: int): int
{var x1 := MultiplicationLoop1M(n, 1, 1);
var x2 := AdditionLoopM(n, 0, x1);
MultiplicationLoop2M(n, 1, x2)}

function f1(n: int): int
{var x1 := MultiplicationLoop11(n, 1, 1);
var x2 := AdditionLoop1(n, 1, x1);
MultiplicationLoop21(n, 1, x2)}

function AdditionLoopM(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then AdditionLoopM(n, (i + 1), (x + i)) else x}

function MultiplicationLoop11(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then MultiplicationLoop11(n, (i + 1), (x * 1)) else x}

function MultiplicationLoop21(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then MultiplicationLoop21(n, (i + 1), (x * 2)) else x}

function MultiplicationLoop1M(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then MultiplicationLoop1M(n, (i + 1), (x * 1)) else x}

function MultiplicationLoop2M(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then MultiplicationLoop2M(n, (i + 1), (x * 2)) else x}

function AdditionLoop1(n: int, i: int, x: int): int
decreases ((n - i))
{if (i <= n) then AdditionLoop1(n, (i + 1), (x + i)) else x}

lemma fM_f1_Equivalence(n: int)
ensures (fM(n) == f1(n))
{{var x1 := MultiplicationLoop1M(n, 1, 1);var x2 := AdditionLoopM(n, 0, x1);MultiplicationLoop2M_MultiplicationLoop21_Equivalence(n, 1, x2);}}

lemma MultiplicationLoop2M_MultiplicationLoop21_Equivalence(n: int, i: int, x: int)
decreases ((n - i))
ensures (MultiplicationLoop2M(n, i, x) == MultiplicationLoop21(n, i, x))
{{match (i <= n) {
case false =>
case true =>MultiplicationLoop2M_MultiplicationLoop21_Equivalence(n, (i + 1), (x * 2));
}
}}

