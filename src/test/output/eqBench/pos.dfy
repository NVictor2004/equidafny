function ClientM(x: int): int
{if (x > 0) then -LibM(-x) else LibM(x)}

function Client1(x: int): int
{if (x > 0) then -Lib1(-x) else Lib1(x)}

function Lib1(x: int): int
decreases (-x)
{if (x < 0) then (1 + Lib1((x + 1))) else 0}

function LibM(x: int): int
{if (x < 0) then -x else x}

lemma ClientM_Client1_Equivalence(x: int)
ensures (ClientM(x) == Client1(x))
{{match (x > 0) {
case false =>LibM_Lib1_Equivalence(x);
case true =>LibM_Lib1_Equivalence(-x);
}
}}

lemma LibM_Lib1_Equivalence(x: int)
ensures (LibM(x) == Lib1(x))
{{}}

