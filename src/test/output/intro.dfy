datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function insertSortedM<Seed>(seed: Seed, next: Seed -> (Seed, int), count: int, xs: List<int>): List<int>
{if (count <= 0) then xs else var (nxtS, t) := next(seed);
insertSortedM(nxtS, next, (count - 1), insertM(xs, t))}

function insertSorted1<Seed>(seed: Seed, next: Seed -> (Seed, int), xs: List<int>, count: int): List<int>
decreases (count)
{if (count <= 0) then xs else var (nxtS, t) := next(seed);
insertSorted1(nxtS, next, insert1(t, xs), (count - 1))}

function insert1(t: int, xs: List<int>): List<int>
decreases (xs)
{match xs {
case Cons(hd, tl) => if (t <= hd) then Cons(t, xs) else Cons(hd, insert1(t, tl))
case Nil => Cons(t, Nil)
}
}

function insertM(xs: List<int>, t: int): List<int>
decreases (xs)
{match xs {
case Nil => Cons(t, Nil)
case Cons(hd, tl) => if (t <= hd) then Cons(t, xs) else Cons(hd, insertM(tl, t))
}
}

lemma insertSortedM_insertSorted1_Equivalence<Seed>(seed: Seed, next: Seed -> (Seed, int), count: int, xs: List<int>)
ensures (insertSortedM(seed, next, count, xs) == insertSorted1(seed, next, xs, count))
{{if (count <= 0){}else {var (nxtS, t) := next(seed);insertM_insert1_Equivalence(xs, t);insertSortedM_insertSorted1_Equivalence(nxtS, next, (count - 1), insertM(xs, t));}}}

lemma insertM_insert1_Equivalence(xs: List<int>, t: int)
decreases (xs)
ensures (insertM(xs, t) == insert1(t, xs))
{{match xs {
case Nil =>
case Cons(hd, tl) =>if (t <= hd){}else {insertM_insert1_Equivalence(tl, t);}
}
}}

