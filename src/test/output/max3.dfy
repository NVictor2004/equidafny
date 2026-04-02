datatype List<A> = Nil | Cons(head: A, tail: List<A>)

ghost function maxM(lst: List<int>): int
{match lst {
case Nil => var x: int :| true;
x
case Cons(hd, tl) => foldM((x, y) => if (x > y) then x else y, lst, hd)
}
}

ghost function max1(lst: List<int>): int
{match lst {
case Nil => var x: int :| true;
x
case Cons(hd, tl) => fold1((x, y) => if (x > y) then x else y, lst, hd)
}
}

function fold1(f: (int, int) -> int, l: List<int>, a: int): int
decreases (l)
{match l {
case Nil => a
case Cons(hd, tl) => f(hd, fold1(f, tl, a))
}
}

function foldM(f: (int, int) -> int, l: List<int>, a: int): int
decreases (l)
{match l {
case Nil => a
case Cons(hd, tl) => f(hd, foldM(f, tl, a))
}
}

function norm(l: List<int>, f: int): int
{match l {
case Nil => -1
case _ => f
}
}

lemma maxM_max1_Equivalence(lst: List<int>)
ensures (norm(lst, maxM(lst)) == norm(lst, max1(lst)))
{{match lst {
case Nil =>
case Cons(hd, tl) =>foldM_fold1_Equivalence((x, y) => if (x > y) then x else y, lst, hd);
}
}}

lemma foldM_fold1_Equivalence(f: (int, int) -> int, l: List<int>, a: int)
decreases (l)
ensures (foldM(f, l, a) == fold1(f, l, a))
{{}}

