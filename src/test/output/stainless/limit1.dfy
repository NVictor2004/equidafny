function limit1_1(n: int): int
{if (n <= 1) then n else (n + limit1_1((n - 1)))}

function limit1_2(n: int): int
{if (n <= 1) then n else (((n + n) - 1) + limit1_2((n - 2)))}

lemma limit1_1_limit1_2_Equivalence(n: int)
ensures (limit1_1(n) == limit1_2(n))
{{match (n <= 1) {
case false =>limit1_1_limit1_2_Equivalence((n - 1));
case true =>
}
}}

