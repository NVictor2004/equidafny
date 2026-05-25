datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function maxM(lst: List<int>): int
decreases (lst)
{match lst {
case Nil => -999999999999
case Cons(hd, Nil) => hd
case Cons(hd, tl) => if (hd > maxM(tl)) then hd else maxM(tl)
}
}

function max5(l: List<int>): int
{-1}

function max4(l: List<int>): int
decreases (l)
{match l {
case Nil => 0
case Cons(hd, tl) => if (hd > max4(tl)) then hd else max4(tl)
}
}

function max2(l: List<int>): int
decreases (l)
{match l {
case Nil => -999999999999
case Cons(h, t) => if (h > max2(t)) then h else max2(t)
}
}

function norm(l: List<int>, f: int): int
{match l {
case Nil => -1
case _ => f
}
}

lemma maxM_max5_Equivalence(lst: List<int>)
decreases (lst)
ensures (norm(lst, maxM(lst)) == norm(lst, max5(lst)))
{{}}

lemma maxM_max4_Equivalence(lst: List<int>)
decreases (lst)
ensures (norm(lst, maxM(lst)) == norm(lst, max4(lst)))
{{match lst {
case Nil =>
case Cons(hd, Nil) =>
case Cons(hd, tl) =>maxM_max4_Equivalence(tl);match (hd > maxM(tl)) {
case false =>maxM_max4_Equivalence(tl);
case true =>
}

}
}}

lemma maxM_max2_Equivalence(lst: List<int>)
decreases (lst)
ensures (norm(lst, maxM(lst)) == norm(lst, max2(lst)))
{{match lst {
case Nil =>
case Cons(hd, Nil) =>
case Cons(hd, tl) =>maxM_max2_Equivalence(tl);match (hd > maxM(tl)) {
case false =>maxM_max2_Equivalence(tl);
case true =>
}

}
}}

