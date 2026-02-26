datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function replace<T(==)>(l1: List<T>, x: T, l2: List<T>): List<T>
decreases (l1)
{match l1 {
case Nil() => Nil
case Cons(y, ys) => if x == y then append(l2, replace(ys, x, l2)) else Cons(y, replace(ys, x, l2))
}
}

function slowReplace<T(==)>(l1: List<T>, x: T, l2: List<T>): List<T>
{join(split(l1, x), l2)}

function join<T>(ll: List<List<T>>, l: List<T>): List<T>
decreases (ll)
{match ll {
case Nil => Nil
case Cons(l1, Nil) => l1
case Cons(l1, ls) => append(append(l1, l), join(ls, l))
}
}

function split<T(==)>(l: List<T>, x: T): List<List<T>>
decreases (l)
{match l {
case Nil => Cons(Nil, Nil)
case Cons(y, ys) => if (x == y) then Cons(Nil, split(ys, x)) else var r := split(ys, x);
Cons(Cons(y, r.head), r.tail)
}
}

function append<T>(l1: List<T>, l2: List<T>): List<T>
decreases (l1)
{match l1 {
case Nil() => l2
case Cons(hd, tl) => Cons(hd, append(tl, l2))
}
}

lemma slowReplaceEquivalence<T(==)>(l1: List<T>, x: T, l2: List<T>)
ensures replace(l1, x, l2) == slowReplace(l1, x, l2)
{{}}

