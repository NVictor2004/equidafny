function factorialM(x: int): int
{if (x < 5) then libM(x) else 0}

function factorial1(x: int): int
{if (x < 5) then lib1(x) else 0}

function lib1(n: int): int
{if (n <= 0) then 1 else (n * lib1((n - 1)))}

function libMHelper(n: int, acc: int, x: int): int
decreases (((n + 1) - x))
{if (x < (n + 1)) then libMHelper(n, (acc * x), (x + 1)) else acc}

function libM(n: int): int
{if (n > 0) then libMHelper(n, 1, 1) else 0}

lemma factorialM_factorial1_Equivalence(x: int)
ensures (factorialM(x) == factorial1(x))
{{match (x < 5) {
case false =>
case true =>libM_lib1_Equivalence(x);
}
}}

lemma libM_lib1_Equivalence(n: int)
ensures (libM(n) == lib1(n))
{{}}

