datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function sumM(l: seq<int>): int
{sumAccM(0, l)}

function sum1(l: List<int>): int
{sumAcc1(l, 0)}

function sumAcc1(l: List<int>, acc: int): int
decreases (l)
{match l {
case Nil => acc
case Cons(h, t) => sumAcc1(t, (acc + h))
}
}

function sumAccM(acc: int, l: seq<int>): int
decreases (l)
{if (|l| == 0) then acc else sumAccM((acc + l[0]), l[1 ..])}

function seqToList(l: seq<int>): List<int>
{if (|l| == 0) then Nil else Cons(l[0], seqToList(l[1 ..]))}

lemma sumM_sum1_Equivalence(l: seq<int>)
ensures (sumM(l) == sum1(seqToList(l)))
{{sumAccM_sumAcc1_Equivalence(0, l);}}

lemma sumAccM_sumAcc1_Equivalence(acc: int, l: seq<int>)
decreases (l)
ensures (sumAccM(acc, l) == sumAcc1(seqToList(l), acc))
{{}}

