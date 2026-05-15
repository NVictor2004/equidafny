datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function solution_2(lst: List<int>): List<int>
decreases (length(lst))
{match lst {
case Nil => Nil
case Cons(hd, tl) => lemM(hd, tl);
Cons(hd, solution_2(drop_2(tl, hd)))
}
}

function uniq2(lst: List<int>): List<int>
decreases (length(lst))
{match lst {
case Nil => Nil
case Cons(hd, tl) => lem2(hd, tl);
Cons(hd, uniq2(drop(hd, tl)))
}
}

function drop(a: int, lst_0: List<int>): List<int>
decreases (lst_0)
{match lst_0 {
case Nil => Nil
case Cons(hd_0, tl_0) => if (a == hd_0) then drop(a, tl_0) else Cons(hd_0, drop(a, tl_0))
}
}

function drop_2(lst: List<int>, n: int): List<int>
decreases (lst)
{match lst {
case Nil => Nil
case Cons(hd, tl) => if (hd == n) then drop_2(tl, n) else Cons(hd, drop_2(tl, n))
}
}

function length<T>(lst: List<T>): nat
decreases (lst)
{match lst {
case Nil => 0
case Cons(_, tl) => (1 + length(tl))
}
}

lemma solution_2_uniq2_Equivalence(lst: List<int>)
decreases (length(lst))
ensures (solution_2(lst) == uniq2(lst))
{{match lst {
case Nil =>
case Cons(hd, tl) =>lemM(hd, tl);drop_2_drop_Equivalence(tl, hd);solution_2_uniq2_Equivalence(drop_2(tl, hd));
}
}}

lemma drop_2_drop_Equivalence(lst: List<int>, n: int)
decreases (lst)
ensures (drop_2(lst, n) == drop(n, lst))
{{match lst {
case Nil =>
case Cons(hd, tl) =>if (hd == n){drop_2_drop_Equivalence(tl, n);}else {drop_2_drop_Equivalence(tl, n);}
}
}}

lemma lem2(a: int, lst: List<int>)
ensures (length(drop(a, lst)) <= length(lst))
{{}}

lemma lemM(n: int, lst: List<int>)
ensures (length(drop_2(lst, n)) <= length(lst))
{{}}

