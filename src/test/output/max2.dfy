datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function maxM(lst: List<int>): int
decreases (lst)
{match lst {
case Nil => -999999999999
case Cons(hd, Nil) => hd
case Cons(hd, tl) => if (hd > maxM(tl)) then hd else maxM(tl)
}
}

function max1(l: List<int>): int
decreases (l)
{match l {
case Nil => 42
case Cons(hd, Nil) => hd
case Cons(hd, tl) => if (hd > max1(tl)) then hd else max1(tl)
}
}

function norm(l: List<int>, f: int): int
{match l {
case Nil => -1
case _ => f
}
}

lemma maxM_max1_Equivalence(lst: List<int>)
decreases (lst)
ensures (norm(lst, maxM(lst)) == norm(lst, max1(lst)))
{{match lst {
case Nil =>
case Cons(hd, Nil) =>
case Cons(hd, tl) =>maxM_max1_Equivalence(tl);if (hd > maxM(tl)){}else {maxM_max1_Equivalence(tl);}
}
}}

