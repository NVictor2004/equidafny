datatype Nat = Zero | Succ(n: Nat)

function addM(n: Nat, m: Nat): Nat
{addHelper(n, m)}

function add1(n: Nat, m: Nat): Nat
{addHelper(m, n)}

function addHelper(n: Nat, m: Nat): Nat
{match n {
case Zero => m
case Succ(n') => Succ(addHelper(n', m))
}
}

lemma addM_add1_Equivalence(n: Nat, m: Nat)
ensures (addM(n, m) == add1(m, n))
{{}}

