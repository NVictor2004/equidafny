function fibM(x: int): int
{if (x < 5) then libM(x) else 0}

function fib1(x: int): int
{if (x < 5) then lib1(x) else 0}

function lib1Helper(n: int, a: int, b: int, i: int): int
decreases ((n - i))
{if (i < n) then lib1Helper(n, b, (a + b), (i + 1)) else a}

function lib1(n: int): int
{lib1Helper(n, 0, 1, 0)}

function libM(n: int): int
{if (n <= 1) then 0 else (libM((n - 1)) + libM((n - 2)))}

lemma fibM_fib1_Equivalence(x: int)
ensures (fibM(x) == fib1(x))
{{match (x < 5) {
case false =>
case true =>libM_lib1_Equivalence(x);
}
}}

lemma libM_lib1_Equivalence(n: int)
ensures (libM(n) == lib1(n))
{{}}

