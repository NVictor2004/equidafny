function clientM(x: int): int
{if (x > 0) then libM(x) else x}

function client1(x: int): int
{if (x > 0) then lib1(x) else x}

function lib1(x: int): int
{if (x <= 0) then -1 else 1}

function libM(x: int): int
{if (x == 0) then 0 else if (x < 0) then -1 else 1}

lemma clientM_client1_Equivalence(x: int)
ensures (clientM(x) == client1(x))
{{match (x > 0) {
case false =>
case true =>libM_lib1_Equivalence(x);
}
}}

lemma libM_lib1_Equivalence(x: int)
ensures (libM(x) == lib1(x))
{{}}

