function clientM(c: int, d: int): int
{if (d == 0) then 0 else libM(c, d)}

function client1(c: int, d: int): int
{if (d == 0) then 0 else lib1(c, d)}

function lib1(x: int, y: int): int
{if (y == 0) then 0 else (x / y)}

function libM(x: int, y: int): int
requires (y != 0)
{(x / y)}

lemma clientM_client1_Equivalence(c: int, d: int)
ensures (clientM(c, d) == client1(c, d))
{{match d {
case 0 =>
case _ =>libM_lib1_Equivalence(c, d);
}
}}

lemma libM_lib1_Equivalence(x: int, y: int)
requires (y != 0)
ensures (libM(x, y) == lib1(x, y))
{{}}

