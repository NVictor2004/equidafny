
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