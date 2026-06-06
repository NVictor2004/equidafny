function clientM(x: int): int
{if (x < 0) then (-libM((-x * 5)) / 5) else ((libM(((x + 1) * 5)) / 5) - 1)}

function client1(x: int): int
{if (x < 0) then (-lib1((-x * 5)) / 5) else ((lib1(((x + 1) * 5)) / 5) - 1)}

function lib1(x: int): int
{if (x < 0) then 0 else x}

function libM(x: int): int
{if (x < 5) then 5 else x}

lemma clientM_client1_Equivalence(x: int)
ensures (clientM(x) == client1(x))
{{match (x < 0) {
case false =>libM_lib1_Equivalence(((x + 1) * 5));
case true =>libM_lib1_Equivalence((-x * 5));
}
}}

lemma libM_lib1_Equivalence(x: int)
ensures (libM(x) == lib1(x))
{{}}

