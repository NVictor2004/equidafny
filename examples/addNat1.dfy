
datatype Nat = Zero | Succ(n: Nat)

function addHelper(n: Nat, m: Nat): Nat {
    match n {
        case Zero => m
        case Succ(n') => Succ(addHelper(n', m))
    }
}

function addM(n: Nat, m: Nat): Nat {
    addHelper(n, m)
}

function add1(n: Nat, m: Nat): Nat {
    addHelper(m, n)
}

lemma equivalence(n: Nat, m: Nat)
    ensures addM(n, m) == add1(m, n)
{}

// Lemmas to prove commutativity of addHelper function

lemma equivalenceCommutativity(n: Nat, m: Nat)
    ensures addHelper(n, m) == addHelper(m, n)
{
    match n {
        case Zero => {}
        case Succ(n') => equivalenceCommutativity(n', m);
    }
}