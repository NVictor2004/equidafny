
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

// Defining isSortedC

function chk(l: List<int>, p: int, a: bool): bool
{
  match l
  case Nil => a
  case Cons(x, xs) => x >= p && chk(xs, x, a)
}

function isSortedC(l: List<int>): bool
{
  match l
  case Nil => true
  case Cons(x, xs) => chk(Cons(x, xs), x, true)
}

// Proving equivalence of isSortedC with isSortedR
// However, here Dafny needs help
// We prove a helper lemma first, using a decreases clause
lemma isSortedEquivalence2Helper(x: int, xs: List<int>)
  decreases xs
  ensures chk(xs, x, true) == loop(x, xs)
{
}

// Then, prove the main equivalence lemma
lemma isSortedEquivalence2(l: List<int>)
  ensures isSortedC(l) == isSortedR(l)
{
  match l
  case Nil => {}
  case Cons(x, xs) =>
    isSortedEquivalence2Helper(x, xs);
}