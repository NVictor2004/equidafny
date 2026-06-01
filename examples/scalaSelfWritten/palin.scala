datatype List<T> = Nil | Cons(head: T, tail: List<T>)
datatype BT = Box | Nd(t1: BT, t2: BT)

function sizeBT(bt: BT): nat {
    match bt {
        case Box => 1
        case Nd(t1, t2) => 1 + sizeBT(t1) + sizeBT(t2)
    }
}

function sizeList(l: List<(BT, BT)>): nat {
    match l {
        case Nil => 0
        case Cons((left, right), t) => sizeBT(left) + sizeBT(right) + sizeList(t)
    }
}

function checkPalin(bt: BT): bool {
    match bt {
        case Box => true
        case Nd(t1, t2) => check((t1, t2))
    }
}

function check(bts: (BT, BT)): bool
    decreases sizeBT(bts.0) + sizeBT(bts.1)
{
    match bts {
        case (Box, Box) => true
        case (Nd(t1, t2), Nd(t3, t4)) => check((t1, t4)) && check((t2, t3))
        case _ => false
    }
}

function check2(l: List<(BT, BT)>): bool
    decreases sizeList(l)
{
    match l {
        case Nil => true
        case Cons((Box, Box), ts) => check2(ts)
        case Cons((Nd(t1, t2), Nd(t3, t4)), ts) =>
            assert sizeList(Cons((t1, t4), Cons((t2, t3), ts))) < sizeList(l);
            check2(Cons((t1, t4), Cons((t2, t3), ts)))
        case _ => false
    }
}

function transform(bts: (BT, BT)): List<(BT, BT)> {
    Cons(bts, Nil)
}