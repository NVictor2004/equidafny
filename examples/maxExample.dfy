
// Define a generic list datatype
datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function length<T>(l: List<T>): nat
{
  match l
  case Nil => 0
  case Cons(_, tl) => 1 + length(tl)
}

function foldLeft<T, U>(f: (U, T) -> U, acc: U, l: List<T>): U
{
  match l
  case Nil => acc
  case Cons(hd, tl) => foldLeft(f, f(acc, hd), tl)
}

// Reference solution
function maxR(l: List<int>): int
{
  match l
  case Nil => -1
  case Cons(hd, Nil) => hd
  case Cons(hd, tl) =>
    if hd > maxR(tl) then hd else maxR(tl)
}

// Defining maxC
function maxC(l: List<int>): int
  decreases length(l)
{
  match l
  case Nil => -1
  case Cons(a, Nil) => a
  case Cons(a, Cons(b, tl)) =>
    if a > b then
      assert length(l) decreases to length(Cons(a, tl));
      maxC(Cons(a, tl))
    else
      maxC(Cons(b, tl))
}

// Defining maxT

// First define a helper function
function bigger(a: int, b: int): int
{
  if a >= b then a else b
}

function maxT(l: List<int>): int
{
  match l
  case Nil => -1
  case Cons(hd, tl) => foldLeft(bigger, hd, tl)
}