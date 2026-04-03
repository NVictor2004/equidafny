
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