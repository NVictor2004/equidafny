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

function norm(l: List<int>, f: int): int
{match l {
case Nil => -1
case _ => f
}
}

function foldM(f: (int, int) -> int, l: List<int>, a: int): int
decreases (l)
{match l {
case Nil => a
case Cons(hd, tl) => f(hd, foldM(f, tl, a))
}
}

lemma maxM_max1_Equivalence(lst: List<int>)
ensures (maxM(lst) == max1(lst))
{{}}

