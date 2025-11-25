
// Example 1: Check whether a list is sorted

// Defining isSortedR
// This is the reference solution
// Requires a clause to prove termination

method loop(p: int, l: seq<int>) returns (res: bool)
  ensures res <==> ((forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1]) && (|l| > 0 ==> p <= l[0]))
{
  var currentP := p;
  var currentL := l;

  while true
    decreases |currentL|
    invariant currentL == l[|l| - |currentL| .. ]
    invariant currentP == if |l| == |currentL| then p else l[|l| - |currentL| - 1]
    invariant |l| > |currentL| ==> p <= l[0]
    invariant forall i :: 0 <= i < |l| - |currentL| - 1 ==> l[i] <= l[i+1]
  {
    if |currentL| == 0 {
        return true;
    } else {
        var x := currentL[0];
        if currentP > x {
            return false;
        }
        currentP := x;
        currentL := currentL[1..];
    }
  }
}

method isSortedR(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
  if |l| == 0 {
    return true;
  } else {
    var x := l[0];
    var xs := l[1..];
    var result := loop(x, xs);
    return result;
  }
}

// Defining isSortedB
method isSortedB(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
  var currentL := l;

  while true
    decreases |currentL|
    invariant currentL == l[|l| - |currentL| .. ]
    invariant forall i :: 0 <= i < |l| - |currentL| ==> (i < |l| - 1 ==> l[i] <= l[i+1])
  {
    if |currentL| == 0 {
        return true;
    } else if |currentL| == 1 {
        currentL := [];
    } else {
        var x := currentL[0];
        var y := currentL[1];
        if x > y {
            return false;
        }
        currentL := currentL[1..];
    }
  }
}

// // Defining isSortedC

// function chk(l: List<int>, p: int, a: bool): bool
// {
//   match l
//   case Nil => a
//   case Cons(x, xs) => x >= p && chk(xs, x, a)
// }

// function isSortedC(l: List<int>): bool
// {
//   match l
//   case Nil => true
//   case Cons(x, xs) => chk(Cons(x, xs), x, true)
// }

// // Proving equivalence of isSortedC with isSortedR
// // However, here Dafny needs help
// // We prove a helper lemma first, using a decreases clause
// lemma isSortedEquivalence2Helper(x: int, xs: List<int>)
//   decreases xs
//   ensures chk(xs, x, true) == loop(x, xs)
// {
// }

// // Then, prove the main equivalence lemma
// lemma isSortedEquivalence2(l: List<int>)
//   ensures isSortedC(l) == isSortedR(l)
// {
//   match l
//   case Nil => {}
//   case Cons(x, xs) =>
//     isSortedEquivalence2Helper(x, xs);
// }

// // Prove equivalence of isSortedC with isSortedB
// // Dafny needs help again
// lemma isSortedEquivalence3(l: List<int>)
//   ensures isSortedC(l) == isSortedB(l)
// {
//   isSortedEquivalence(l);
//   isSortedEquivalence2(l);
// }

// // Defining isSortedA

// function leq(cur: int, next: int): bool
// {
//   cur < next
// }

// function iter(l: List<int>): bool
// {
//   match l
//   case Nil => true
//   case Cons(x, Nil) => true
//   case Cons(x, Cons(y, ys)) => leq(x, y) && iter(Cons(y, ys))
// }

// function isSortedA(l: List<int>): bool
// {
//   match l
//   case Nil => true
//   case Cons(_, Nil) => true
//   case Cons(x, Cons(y, ys)) => x <= y && iter(Cons(y, ys))
// }

// // Proving equivalence of isSortedA with isSortedR

// // Without the helper lemma, Dafny provides the counter example of Cons(-38, Cons(7681, Nil))
// // However, both functions return true for this input, so this is not a valid counter example
// // Also, this is a terrible counter example

// // With the helper lemma, Dafny successfully provides a correct counter example of
// // x = 8855, xs = Cons(8855, Nil)
// // However, this is still a terrible counter example

// lemma isSortedEquivalence4Helper(x: int, xs: List<int>)
//   decreases xs
//   ensures iter(Cons(x, xs)) == loop(x, xs)
// {
// }

// lemma isSortedEquivalence4(l: List<int>)
//   ensures isSortedA(l) == isSortedR(l)
// {
//   match l
//   case Nil => {}
//   case Cons(x, Nil) => {}
//   case Cons(x, Cons(y, ys)) => isSortedEquivalence4Helper(y, ys);
// }