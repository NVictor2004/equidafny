datatype Term = Val(v: int) | UMinus(t: Term) | Mult(left: Term, right: Term)

function eval(t: Term): int {
    match t {
        case Val(v) => v
        case UMinus(t) => -eval(t)
        case Mult(left, right) => eval(left) * eval(right)
    }
}

function rip(t: Term): Term {
    match t {
        case Val(v) => Val(v)
        case UMinus(t) => rip(t)
        case Mult(left, right) => Mult(rip(left), rip(right))
    }
}

function pos(t: Term): bool {
    match t {
        case Val(v) => true
        case UMinus(t) => !pos(t)
        case Mult(left, right) => pos(left) == pos(right)
    }
}

function wSign(i: int, b: bool): int {
    if b then i else -i
}

function evalM(t: Term): int {
    eval(t)
}

function eval1(t: Term): int {
    wSign(eval(rip(t)), pos(t)) 
}