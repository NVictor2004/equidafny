function clientM(x: int): int
{if ((x < -100) || (x > 100)) then x else if (x > libM(x)) then x else libM(x)}

function client1(x: int): int
{if ((x < -100) || (x > 100)) then x else if (x > lib1(x)) then x else lib1(x)}

function lib1(x: int): int
{if (x > 11) then 11 else (x - 1)}

function libM(x: int): int
{if (x > 10) then 11 else x}

lemma clientM_client1_Equivalence(x: int)
ensures (clientM(x) == client1(x))
{{match match (x < -100) {
case false => (x > 100)
case true => true
}
 {
case false =>libM_lib1_Equivalence(x);match (x > libM(x)) {
case false =>libM_lib1_Equivalence(x);
case true =>
}

case true =>
}
}}

lemma libM_lib1_Equivalence(x: int)
ensures (libM(x) == lib1(x))
{{}}

