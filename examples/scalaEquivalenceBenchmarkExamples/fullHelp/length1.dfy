datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function lengthM<T>(l: List<T>): int {
    match l {
        case Nil => 0
        case Cons(_, t) => 1 + lengthM(t)
    }
}

function length1<T>(l: List<T>): int {
    if l == Nil then 0 else 1 + length1(l.tail)
}

lemma lengthEquivalence<T>(l: List<T>)
    ensures lengthM(l) == length1(l)
{}