const PRIMES1: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

const PRIMESM: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

function ClientM(x: nat): int
{if (x < 19) then LibM(20, 1) else LibM(x, 1)}

function Client1(x: nat): int
{if (x < 19) then Lib1(20, 1) else Lib1(x, 1)}

function LibLoop1(x: nat, i: int): int
requires (0 <= i)
requires (i <= |PRIMES1|)
decreases ((|PRIMES1| - i))
{if (i == |PRIMES1|) then 1 else var mod := (x % PRIMES1[i]);
if (mod == 0) then if (x == PRIMES1[i]) then 1 else 0 else LibLoop1(x, (i + 1))}

function Lib1(x: nat, b: int): int
{if (b == 0) then 0 else LibLoop1(x, 0)}

function LibLoopM(x: nat, i: int): int
requires (0 <= i)
requires (i <= |PRIMESM|)
decreases ((|PRIMESM| - i))
{if (i == |PRIMESM|) then 1 else var mod := (x % PRIMESM[i]);
if (mod == 0) then 0 else LibLoopM(x, (i + 1))}

function LibM(x: nat, b: int): int
{if (b == 0) then 0 else LibLoopM(x, 0)}

lemma ClientM_Client1_Equivalence(x: nat)
ensures (ClientM(x) == Client1(x))
{{match (x < 19) {
case false =>LibM_Lib1_Equivalence(x, 1);
case true =>LibM_Lib1_Equivalence(20, 1);
}
}}

lemma LibLoopM_LibLoop1_Equivalence(x: nat, i: int)
requires (0 <= i)
requires (i <= |PRIMESM|)
decreases ((|PRIMESM| - i))
ensures (LibLoopM(x, i) == LibLoop1(x, i))
{{match (i == |PRIMESM|) {
case false =>var mod := (x % PRIMESM[i]);match mod {
case 0 =>
case _ =>LibLoopM_LibLoop1_Equivalence(x, (i + 1));
}

case true =>
}
}}

lemma LibM_Lib1_Equivalence(x: nat, b: int)
ensures (LibM(x, b) == Lib1(x, b))
{{match b {
case 0 =>
case _ =>LibLoopM_LibLoop1_Equivalence(x, 0);
}
}}

