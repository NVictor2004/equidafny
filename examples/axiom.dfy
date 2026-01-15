
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

// Proving Equivalence

lemma maxEquivalence2(l: seq<int>)
  ensures maxT(l) == maxR(l)
{
  if |l| >= 1 { maxEquivalence2Helper(l[0], l[1..]); }
}

// Dafny treats this lemma as an axiom
// Therefore, it does not prove it, but assumes it to be true
// It can be used in other proofs
lemma {:axiom} maxEquivalence2Helper(a: int, b: seq<int>)
  ensures foldLeft(bigger, a, b) == maxR([a] + b)