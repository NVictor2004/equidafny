const PRIMES1: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

const PRIMESM: seq<nat> := [2, 3, 5, 7, 11, 13, 17, 19]

function ClientM(x: nat): int
{LibM(x, 0)}

function Client1(x: nat): int
{Lib1(x, 0)}

function LibLoop1(x: nat, i: int): int
requires (0 <= i)
requires (i <= |PRIMES1|)
decreases ((|PRIMES1| - i))
{if (i == |PRIMES1|) then 1 else var p := PRIMES1[i];
if ((x % p) == 0) then if (x == p) then 1 else 0 else LibLoop1(x, (i + 1))}

function Lib1(x: nat, b: int): int
{if (b == 0) then 0 else LibLoop1(x, 0)}

function LibLoopM(x: nat, i: int): int
requires (0 <= i)
requires (i <= |PRIMESM|)
decreases ((|PRIMESM| - i))
{if (i == |PRIMESM|) then 1 else var p := PRIMESM[i];
if ((x % p) == 0) then 0 else LibLoopM(x, (i + 1))}

function LibM(x: nat, b: int): int
{if (b == 0) then 0 else LibLoopM(x, 0)}

lemma ClientM_Client1_Equivalence(x: nat)
ensures (ClientM(x) == Client1(x))
{{LibM_Lib1_Equivalence(x, 0);}}

lemma LibLoopM_LibLoop1_Equivalence(x: nat, i: int)
requires (0 <= i)
requires (i <= |PRIMESM|)
decreases ((|PRIMESM| - i))
ensures (LibLoopM(x, i) == LibLoop1(x, i))
{{match (i == |PRIMESM|) {
case false =>var p := PRIMESM[i];match ((x % p) == 0) {
case false =>LibLoopM_LibLoop1_Equivalence(x, (i + 1));
case true =>
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

