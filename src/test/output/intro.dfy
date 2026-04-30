datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function insertRandomSortedM<A>(seed: A, next: A -> (A, int), count: int, xs: List<int>): List<int>
{if (count <= 0) then xs else var (nxtS, t) := next(seed);
insertRandomSortedM(nxtS, next, (count - 1), insertM(xs, t))}

function insertRandomSorted1<A>(seed: A, next: A -> (A, int), xs: List<int>, count: int): List<int>
decreases (count)
{if (count <= 0) then xs else var (nxtS, t) := next(seed);
insertRandomSorted1(nxtS, next, insert1(t, xs), (count - 1))}

function insert1(t: int, xs: List<int>): List<int>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if (t <= hd) then Cons(t, xs) else Cons(hd, insert1(t, tl))
}
}

function insertM(xs: List<int>, t: int): List<int>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if (t <= hd) then Cons(t, xs) else Cons(hd, insertM(tl, t))
}
}

lemma insertRandomSortedM_insertRandomSorted1_Equivalence<A>(seed: A, next: A -> (A, int), count: int, xs: List<int>)
ensures (insertRandomSortedM(seed, next, count, xs) == insertRandomSorted1(seed, next, xs, count))
{{if (count <= 0){}else {var (nxtS, t) := next(seed);insertM_insert1_Equivalence(xs, t);insertRandomSortedM_insertRandomSorted1_Equivalence(nxtS, next, (count - 1), insertM(xs, t));}}}

lemma insertM_insert1_Equivalence(xs: List<int>, t: int)
decreases (xs)
ensures (insertM(xs, t) == insert1(t, xs))
{{match xs {
case Nil =>
case Cons(hd, tl) =>if (t <= hd){}else {insertM_insert1_Equivalence(tl, t);}
}
}}

