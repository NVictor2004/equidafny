datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function lengthM<A>(l: List<A>): int
{match l {
case Nil => 0
case Cons(_, t) => (1 + lengthM(t))
}
}

function length1<A>(l: List<A>): int
{if (l == Nil) then 0 else (1 + length1(l.tail))}

lemma lengthM_length1_Equivalence<A>(l: List<A>)
ensures (lengthM(l) == length1(l))
{{}}

