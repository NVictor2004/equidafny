
datatype Nat = Zero | Succ(n: Nat)

function addHelperM(n: Nat, m: Nat): Nat {
    match n {
        case Zero => m
        case Succ(n') => Succ(addHelperM(n', m))
    }
}

function addHelper1(n: Nat, m: Nat): Nat {
    match n {
        case Zero => m
        case Succ(n') => Succ(addHelper1(n', m))
    }
}

function addM(n: Nat, m: Nat): Nat {
    addHelperM(n, m)
}

function add1(n: Nat, m: Nat): Nat {
    addHelper1(m, n)
}

lemma equivalence(n: Nat, m: Nat)
    ensures addM(n, m) == add1(m, n)
{
    equivalenceHelper(n, m);
}

lemma equivalenceHelper(n: Nat, m: Nat)
    ensures addHelperM(n, m) == addHelper1(n, m)
{
    match n {
        case Zero => {}
        case Succ(n') => equivalenceHelper(n', m);
    }
}