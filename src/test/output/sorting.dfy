datatype List<A> = Nil | Cons(head: A, tail: List<A>)

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
case Cons(x, Cons(y, ys)) => x <= y && iter(Cons(y, ys))
}
}

function isSortedC(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, xs) => chk(Cons(x, xs), x, true)
}
}

function isSortedB(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, Nil) => isSortedB(Nil)
case Cons(x, Cons(y, ys)) => x <= y && isSortedB(Cons(y, ys))
}
}

function iter(l: List<int>): bool
{match l {
case Nil => true
case Cons(x, Nil) => true
case Cons(x, Cons(y, ys)) => leq(x, y) && iter(Cons(y, ys))
}
}

function leq(cur: int, next: int): bool
{cur < next}

function chk(l: List<int>, p: int, a: bool): bool
{match l {
case Nil => a
case Cons(x, xs) => x >= p && chk(xs, x, a)
}
}

function loop(p: int, l: List<int>): bool
decreases l
{match l {
case Nil => true
case Cons(x, xs) => p <= x && loop(x, xs)
}
}

lemma isSortedR_isSortedA_Equivalence(l: List<int>)
ensures isSortedR(l) == isSortedA(l)
{{}}

lemma isSortedR_isSortedC_Equivalence(l: List<int>)
ensures isSortedR(l) == isSortedC(l)
{{}}

lemma isSortedR_isSortedB_Equivalence(l: List<int>)
ensures isSortedR(l) == isSortedB(l)
{{}}

