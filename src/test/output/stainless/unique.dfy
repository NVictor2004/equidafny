datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function uniqR(lst: List<int>): List<int>
{unique(lst, Nil)}

function uniqA(lst: List<int>): List<int>
{distinct(Nil, lst)}

function find(lst: List<int>, n: int): bool
{match lst {
case Nil => false
case Cons(hd, tl) => ((n == hd) || find(tl, n))
}
}

function isin(a: int, lst: List<int>): bool
{match lst {
case Nil => false
case Cons(hd, tl) => ((a == hd) || isin(a, tl))
}
}

function distinct(a: List<int>, b: List<int>): List<int>
decreases (b)
{match b {
case Nil => a
case Cons(hd, tl) => if isin(hd, a) then distinct(a, tl) else distinct(append(a, Cons(hd, Nil)), tl)
}
}

function unique(l: List<int>, r: List<int>): List<int>
{match l {
case Nil => r
case Cons(hd, tl) => if !find(r, hd) then unique(tl, append(r, Cons(hd, Nil))) else unique(tl, r)
}
}

function append(l1: List<int>, l2: List<int>): List<int>
{match l1 {
case Nil => l2
case Cons(hd, tl) => Cons(hd, append(tl, l2))
}
}

lemma uniqR_uniqA_Equivalence(lst: List<int>)
ensures (uniqR(lst) == uniqA(lst))
{{unique_distinct_Equivalence(lst, Nil);}}

lemma find_isin_Equivalence(lst: List<int>, n: int)
ensures (find(lst, n) == isin(n, lst))
{{match lst {
case Nil =>
case Cons(hd, tl) =>match (n == hd) {
case false =>find_isin_Equivalence(tl, n);
case true =>
}

}
}}

lemma unique_distinct_Equivalence(l: List<int>, r: List<int>)
ensures (unique(l, r) == distinct(r, l))
{{match l {
case Nil =>
case Cons(hd, tl) =>find_isin_Equivalence(r, hd);match find(r, hd) {
case false =>unique_distinct_Equivalence(tl, append(r, Cons(hd, Nil)));
case true =>unique_distinct_Equivalence(tl, r);
}

}
}}

