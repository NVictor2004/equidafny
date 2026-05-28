
// Example 1: Check whether a list is sorted

// Creating a list data structure
datatype List<T> = Nil | Cons(head: T, tail: List<T>)

// Defining isSortedR
// This is the reference solution
// Requires a clause to prove termination
function loop(p: int, l: List<int>): bool
  decreases l
{
  match l
  case Nil => true
  case Cons(x, xs) => p <= x && loop(x, xs)
}

function isSortedR(l: List<int>): bool
{
  match l
  case Nil => true
  case Cons(x, xs) => loop(x, xs)
}

// Defining isSortedB
function isSortedB(l: List<int>): bool
{
  match l
  case Nil => true
  case Cons(x, Nil) => isSortedB(Nil)
  case Cons(x, Cons(y, ys)) => x <= y && isSortedB(Cons(y, ys))
}

// Proving equivalence of both functions
// Dafny can prove this automatically
lemma isSortedEquivalence(l: List<int>)
  ensures isSortedR(l) == isSortedB(l)
{}