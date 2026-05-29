datatype Nat = Zero | Succ(n: Nat)

function addM(n: Nat, m: Nat): Nat
{addHelperM(n, m)}

function add1(n: Nat, m: Nat): Nat
{addHelper1(m, n)}

function addHelper1(n: Nat, m: Nat): Nat
{match n {
case Zero => m
case Succ(n') => Succ(addHelper1(n', m))
}
}

function addHelperM(n: Nat, m: Nat): Nat
{match n {
case Zero => m
case Succ(n') => Succ(addHelperM(n', m))
}
}

lemma addM_add1_Equivalence(n: Nat, m: Nat)
ensures (addM(n, m) == add1(m, n))
{{addHelperM_addHelper1_Equivalence(n, m);}}

lemma addHelperM_addHelper1_Equivalence(n: Nat, m: Nat)
ensures (addHelperM(n, m) == addHelper1(n, m))
{{match n {
case Zero =>
case Succ(n') =>addHelperM_addHelper1_Equivalence(n', m);
}
}}

