
// Basic functions to sum values from 1 to n
// Option 1: Using Triangular Number Formula
function sumN1(n: int): (s: int)
{
  (n * (n + 1)) / 2
}

// Option 2: Using Recursion
function sumN2(n: int): (s: int)
  requires n >= 0
{
  match n
  case 0 => 0
  case n => sumN2(n - 1) + n
}

// Dafny can prove equivalence of both functions
lemma sumEquivalence(n: int)
  requires n >= 0
  ensures sumN1(n) == sumN2(n)
{}

// Another way to express the equivalence
// However, here Dafny needs help
lemma sumEquivalence2(n: int)
  requires n >= 1
  ensures sumN1(n) == sumN2(n - 1) + n
{
  sumEquivalence(n);
}



