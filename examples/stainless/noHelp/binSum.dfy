// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function length<T>(l: List<T>): nat
  {
  match l
    case Nil => 0
    case Cons(_, t) => 1 + length(t)
  }

// This tests the normalization function where the return type is changed


function binSumM(l1: List<bool>, l2: List<bool>, c: bool): List<bool>
  decreases length(l1) + length(l2)
  {
    match (l1, l2)
    case (Nil, Nil) => Nil
    case (Cons(true, t1), Cons(false, t2)) => Cons(!c, binSumM(t1, t2, c))
    case (Cons(false, t1), Cons(true, t2)) => Cons(!c, binSumM(t1, t2, c))
    case (Cons(false, t1), Cons(false, t2)) => Cons(c, binSumM(t1, t2, false))
    case (Cons(true, t1), Cons(true, t2)) => Cons(c, binSumM(t1, t2, true))
    case (Cons(true, t1), Nil) => Cons(!c, binSumM(t1, Nil, c))
    case (Cons(false, t1), Nil) => Cons(c, binSumM(t1, Nil, false))
    case (Nil, Cons(true, t2)) => Cons(!c, binSumM(t2, Nil, c))
    case (Nil, Cons(false, t2)) => Cons(c, binSumM(t2, Nil, false))
  }

function norm(l1: List<bool>, l2: List<bool>, c: bool, res: List<bool>): int
  {listToInt(res)} // transform the semi-specified output to absorb trailing 0s
function listToInt(l: List<bool>): int {
  match l
  case Nil => 0
  case Cons(true, tl) => 1 + 2 * listToInt(tl)
  case Cons(false, tl) => 2 * listToInt(tl)
  }

// CANDIDATE

function binSum1(l1: List<bool>, l2: List<bool>, c: bool): List<bool>
  decreases length(l1) + length(l2)
{
  match (l1, l2, c)
    case (Nil, Nil, _) => Cons(false, Nil)
    case (Cons(true, t1), Cons(false, t2), false) => Cons(true, binSum1(t1, t2, false))
    case (Cons(true, t1), Cons(false, t2), true) => Cons(false, binSum1(t1, t2, true))
    case (Cons(false, t1), Cons(true, t2), false) => Cons(true, binSum1(t1, t2, false))
    case (Cons(false, t1), Cons(true, t2), true) => Cons(false, binSum1(t1, t2, true))
    case (Cons(false, t1), Cons(false, t2), false) => Cons(false, binSum1(t1, t2, false))
    case (Cons(false, t1), Cons(false, t2), true) => Cons(true, binSum1(t1, t2, false))
    case (Cons(true, t1), Cons(true, t2), false) => Cons(false, binSum1(t1, t2, true))
    case (Cons(true, t1), Cons(true, t2), true) => Cons(true, binSum1(t1, t2, true))
    case (Cons(true, t1), Nil, true) => Cons(false, binSum1(t1, Nil, true))
    case (Cons(true, t1), Nil, false) => Cons(true, binSum1(t1, Nil, false))
    case (Cons(false, t1), Nil, true) => Cons(true, binSum1 (t1, Nil, false))
    case (Cons(false, t1), Nil, false) => Cons(false, binSum1(t1, Nil, false))
    case (Nil, Cons(true, t1), true) => Cons(false, binSum1(t1, Nil, true))
    case (Nil, Cons(true, t1), false) => Cons(true, binSum1(t1, Nil, false))
    case (Nil, Cons(false, t1), true) => Cons(true, binSum1(t1, Nil, false))
    case (Nil, Cons(false, t1), false) => Cons(false, binSum1(t1, Nil, false))
}
