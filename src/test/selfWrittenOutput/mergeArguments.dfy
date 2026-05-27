datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function insertSortedM(insert: List<int>, sorted: List<int>): List<int>
{match insert {
case Nil => sorted
case Cons(x, xs) => insertSortedM(xs, insertM(sorted, x))
}
}

function insertSorted1(sorted: List<int>, insert: List<int>): List<int>
decreases (insert)
{match insert {
case Nil => sorted
case Cons(x, xs) => insertSorted1(insert1(x, sorted), xs)
}
}

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

lemma insertSortedM_insertSorted1_Equivalence(insert: List<int>, sorted: List<int>)
ensures (insertSortedM(insert, sorted) == insertSorted1(sorted, insert))
{{match insert {
case Nil =>
case Cons(x, xs) =>insertM_insert1_Equivalence(sorted, x);insertSortedM_insertSorted1_Equivalence(xs, insertM(sorted, x));
}
}}

lemma insertM_insert1_Equivalence(xs: List<int>, t: int)
decreases (xs)
ensures (insertM(xs, t) == insert1(t, xs))
{{match xs {
case Nil =>
case Cons(hd, tl) =>match (t <= hd) {
case false =>insertM_insert1_Equivalence(tl, t);
case true =>
}

}
}}

