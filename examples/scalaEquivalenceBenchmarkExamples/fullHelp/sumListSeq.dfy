datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function sumAccM(acc: int, l: seq<int>): int
    decreases l
{
    if |l| == 0 then acc
    else sumAccM(acc + l[0], l[1..])
}

function sumM(l: seq<int>): int {
    sumAccM(0, l)
}

function sumAcc1(l: List<int>, acc: int): int
    decreases l
{
    match l {
        case Nil => acc
        case Cons(h, t) => sumAcc1(t, acc + h)
    }
}

function sum1(l: List<int>): int {
    sumAcc1(l, 0)
}

function seqToList(l: seq<int>): List<int> {
    if |l| == 0 then Nil
    else Cons(l[0], seqToList(l[1..]))
}

lemma equivalenceHelper(acc: int, l: seq<int>)
  ensures sumAccM(acc, l) == sumAcc1(seqToList(l), acc)
  decreases l
{}

lemma equivalence(l: seq<int>)
  ensures sumM(l) == sum1(seqToList(l))
{
    equivalenceHelper(0, l);
}