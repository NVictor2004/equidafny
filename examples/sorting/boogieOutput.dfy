// Defining isSortedR
// This is the reference solution
// Requires a clause to prove termination
function loop(p: int, l: seq<int>): bool
  decreases l
{
  if |l| == 0 then true
  else p <= l[0] && loop(l[0], l[1..])
}

function isSortedR(l: seq<int>): bool
{
  if |l| == 0 then true
  else loop(l[0], l[1..])
}

// Defining isSortedB
function isSortedB(l: seq<int>): bool
  decreases |l|
{
  if |l| == 0 then true
  else if |l| == 1 then isSortedB([])
  else l[0] <= l[1] && isSortedB(l[1..])
}

// Proving equivalence of both functions
// Dafny can prove this automatically
lemma isSortedEquivalence(l: seq<int>)
  ensures isSortedR(l) == isSortedB(l)
{}