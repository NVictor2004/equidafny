datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function sumM(l: List<int>): int
{match l {
case Nil => 0
case Cons(h, t) => (h + sumM(t))
}
}

function sum1(data: (List<int>, int)): int
decreases (data.0)
{match data {
case (Nil, acc) => acc
case (Cons(h, t), acc) => sum1((t, (h + acc)))
}
}

function transform(l: List<int>): (List<int>, int)
{(l, 0)}

lemma sumM_sum1_Equivalence(l: List<int>)
ensures (sumM(l) == sum1(transform(l)))
{{}}

