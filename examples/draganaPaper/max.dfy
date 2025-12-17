
// Define a generic list datatype
datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function length<T>(l: List<T>): nat
{
  match l
  case Nil => 0
  case Cons(_, tl) => 1 + length(tl)
}

function foldLeft<T, U>(f: (U, T) -> U, acc: U, l: seq<T>): U
{
  if |l| == 0 then acc
  else foldLeft(f, f(acc, l[0]), l[1..])
}

// Reference solution
function maxR(l: seq<int>): int
{
  if |l| == 0 then -1
  else if |l| == 1 then l[0]
  else
    var m := maxR(l[1..]);
    if l[0] > m then l[0] else m
}

// Defining maxC
function maxC(l: seq<int>): int
  decreases |l|
{
  if |l| == 0 then -1
  else if |l| == 1 then l[0]
  else
    var a := l[0];
    var b := l[1];
    if a > b then
      maxC([l[0]] + l[2..])
    else
      maxC(l[1..])
}

lemma maxEquivalence(l: seq<int>)
  ensures maxC(l) == maxR(l)
  decreases |l|
{}

// Defining maxT

// First define a helper function
function bigger(a: int, b: int): int
{
  if a >= b then a else b
}

function maxT(l: seq<int>): int
{
  if |l| == 0 then -1
  else foldLeft(bigger, l[0], l[1..])
}

lemma maxEquivalence2(l: seq<int>)
  ensures maxT(l) == maxR(l)
{
  if |l| >= 1 { maxEquivalence2Helper(l[0], l[1..]); }
}

lemma maxEquivalence2Helper(a: int, b: seq<int>)
  ensures foldLeft(bigger, a, b) == maxR([a] + b)
  decreases |b|
{}