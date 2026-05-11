datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function isSortedR(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, xs) => loop(x, xs)
}
}

function isSortedB(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, Nil) => isSortedB(Nil)
case Cons(x, Cons(y, ys)) => ((x <= y) && isSortedB(Cons(y, ys)))
}
}

function loop(p: int, l: List<int>): bool
decreases (l)
{match l {
case Nil => true
case Cons(x, xs) => ((p <= x) && loop(x, xs))
}
}

lemma isSortedR_isSortedB_Equivalence(l: List<int>)
ensures (isSortedR(l) == isSortedB(l))
{{match l {
case Nil =>
case Cons(x, xs) =>
}
}}

