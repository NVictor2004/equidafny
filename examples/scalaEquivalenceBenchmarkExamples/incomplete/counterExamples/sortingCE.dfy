
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

// Defining isSortedA

function leq(cur: int, next: int): bool
{
  cur < next
}

function iter(l: List<int>): bool
{
  match l
  case Nil => true
  case Cons(x, Nil) => true
  case Cons(x, Cons(y, ys)) => leq(x, y) && iter(Cons(y, ys))
}

function isSortedA(l: List<int>): bool
{
  match l
  case Nil => true
  case Cons(_, Nil) => true
  case Cons(x, Cons(y, ys)) => x <= y && iter(Cons(y, ys))
}

// Proving equivalence of isSortedA with isSortedR

// Without the helper lemma, Dafny provides the counter example of Cons(-38, Cons(7681, Nil))
// However, both functions return true for this input, so this is not a valid counter example
// Also, this is a terrible counter example

// With the helper lemma, Dafny successfully provides a correct counter example of
// x = 8855, xs = Cons(8855, Nil)
// However, this is still a terrible counter example

lemma isSortedEquivalence4Helper(x: int, xs: List<int>)
  decreases xs
  ensures iter(Cons(x, xs)) == loop(x, xs)
{
}

lemma isSortedEquivalence4(l: List<int>)
  ensures isSortedA(l) == isSortedR(l)
{
  match l
  case Nil => {}
  case Cons(x, Nil) => {}
  case Cons(x, Cons(y, ys)) => isSortedEquivalence4Helper(y, ys);
}