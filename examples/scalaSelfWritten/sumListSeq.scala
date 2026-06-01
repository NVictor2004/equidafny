datatype List<T> = Nil | Cons(head: T, tail: List<T>)

def sumAccM(acc: int, l: seq<int>): int
    decreases l
{
    if |l| == 0 then acc
    else sumAccM(acc + l[0], l[1..])
}

def sumM(l: seq<int>): int {
    sumAccM(0, l)
}

def sumAcc1(l: List<int>, acc: int): int
    decreases l
{
    match l {
        case Nil => acc
        case Cons(h, t) => sumAcc1(t, acc + h)
    }
}

def sum1(l: List<int>): int {
    sumAcc1(l, 0)
}

def seqToList(l: seq<int>): List<int> {
    if |l| == 0 then Nil
    else Cons(l[0], seqToList(l[1..]))
}