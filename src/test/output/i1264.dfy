datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function replace<A(==)>(l1: List<A>, x: A, l2: List<A>): List<A>
decreases (l1)
{match l1 {
case Nil => Nil
case Cons(y, ys) => if (x == y) then append(l2, replace(ys, x, l2)) else Cons(y, replace(ys, x, l2))
}
}

function slowReplace<A(==)>(l1: List<A>, x: A, l2: List<A>): List<A>
{join(split(l1, x), l2)}

function join<A>(ll: List<List<A>>, l: List<A>): List<A>
decreases (ll)
{match ll {
case Nil => Nil
case Cons(l1, Nil) => l1
case Cons(l1, ls) => append(append(l1, l), join(ls, l))
}
}

function split<A(==)>(l: List<A>, x: A): List<List<A>>
decreases (l)
{match l {
case Nil => Cons(Nil, Nil)
case Cons(y, ys) => if (x == y) then Cons(Nil, split(ys, x)) else var r := split(ys, x);
Cons(Cons(y, r.head), r.tail)
}
}

function append<A>(l1: List<A>, l2: List<A>): List<A>
decreases (l1)
{match l1 {
case Nil => l2
case Cons(hd, tl) => Cons(hd, append(tl, l2))
}
}

lemma replace_slowReplace_Equivalence<A(==)>(l1: List<A>, x: A, l2: List<A>)
decreases (l1)
ensures (replace(l1, x, l2) == slowReplace(l1, x, l2))
{{}}

