datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function solution_3(lst: List<int>): List<int>
{unique_3(lst, Nil)}

function uniq1(lst: List<int>): List<int>
{app(lst, Nil())}

function is_in_3(lst: List<int>, a: int): bool
decreases (lst)
{match lst {
case Nil => false
case Cons(hd, tl) => if (a == hd) then true else is_in_3(tl, a)
}
}

function check(element: int, l: List<int>): bool
decreases (l)
{match l {
case Nil => false
case Cons(hd, tl) => if (element == hd) then true else check(element, tl)
}
}

function app(l1: List<int>, l2: List<int>): List<int>
decreases (l1)
{match l1 {
case Nil => l2
case Cons(hd, tl) => if check(hd, l2) then app(tl, l2) else app(tl, snoc(l2, hd))
}
}

function unique_3(lst1: List<int>, lst2: List<int>): List<int>
decreases (lst1)
{match lst1 {
case Nil => lst2
case Cons(hd, tl) => if is_in_3(lst2, hd) then unique_3(tl, lst2) else unique_3(tl, snoc(lst2, hd))
}
}

function snoc<T>(l: List<T>, elem: T): List<T>
{match l {
case Nil => Cons(elem, Nil)
case Cons(hd, tl) => Cons(hd, snoc(tl, elem))
}
}

lemma solution_3_uniq1_Equivalence(lst: List<int>)
ensures (solution_3(lst) == uniq1(lst))
{{unique_3_app_Equivalence(lst, Nil);}}

lemma unique_3_app_Equivalence(lst1: List<int>, lst2: List<int>)
decreases (lst1)
ensures (unique_3(lst1, lst2) == app(lst1, lst2))
{{match lst1 {
case Nil =>
case Cons(hd, tl) =>is_in_3_check_Equivalence(lst2, hd);if is_in_3(lst2, hd){unique_3_app_Equivalence(tl, lst2);}else {unique_3_app_Equivalence(tl, snoc(lst2, hd));}
}
}}

lemma is_in_3_check_Equivalence(lst: List<int>, a: int)
decreases (lst)
ensures (is_in_3(lst, a) == check(a, lst))
{{match lst {
case Nil =>
case Cons(hd, tl) =>if (a == hd){}else {is_in_3_check_Equivalence(tl, a);}
}
}}

