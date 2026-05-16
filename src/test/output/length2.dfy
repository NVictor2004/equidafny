datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function lengthM<T>(l: List<T>): int
{match l {
case Nil => 0
case Cons(_, t) => lengthTailM(1, t)
}
}

function length1<T>(l: List<T>): int
{if (l == Nil) then 0 else lengthTail1(l.tail, 1)}

function lengthTail1<T>(l: List<T>, acc: int): int
decreases (l)
{match l {
case Nil => acc
case Cons(_, t) => lengthTail1(t, (acc + 1))
}
}

function lengthTailM<T>(acc: int, l: List<T>): int
decreases (l)
{match l {
case Nil => acc
case Cons(_, t) => lengthTailM((acc + 1), t)
}
}

lemma lengthM_length1_Equivalence<T>(l: List<T>)
ensures (lengthM(l) == length1(l))
{{match l {
case Nil =>
case Cons(_, t) =>lengthTailM_lengthTail1_Equivalence(1, t);
}
}}

lemma lengthTailM_lengthTail1_Equivalence<T>(acc: int, l: List<T>)
decreases (l)
ensures (lengthTailM(acc, l) == lengthTail1(l, acc))
{{match l {
case Nil =>
case Cons(_, t) =>lengthTailM_lengthTail1_Equivalence((acc + 1), t);
}
}}

