
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
