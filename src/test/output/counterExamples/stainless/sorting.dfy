datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function isSortedR(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, xs) => loop(x, xs)
}
}

function isSortedA(l: List<int>): bool
{match l {
case Nil => true
case Cons(_, Nil) => true
case Cons(x, Cons(y, ys)) => ((x <= y) && iter(Cons(y, ys)))
}
}

function iter(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, Nil) => true
case Cons(x, Cons(y, ys)) => (leq(x, y) && iter(Cons(y, ys)))
}
}

function leq(cur: int, next: int): bool
{(cur < next)}

function loop(p: int, l: List<int>): bool
decreases (l)
{match l {
case Nil => true
case Cons(x, xs) => ((p <= x) && loop(x, xs))
}
}

lemma isSortedR_isSortedA_Equivalence(l: List<int>)
ensures (isSortedR(l) == isSortedA(l))
{{}}

