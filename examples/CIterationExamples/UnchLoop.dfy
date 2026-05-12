// MODEL

// Main entry point equivalent to int foo(int a, int b)
function FooM(a: int, b: int): int {
  FooLoopM(a, b, 0, 0) + 1
}

// Recursive helper representing the 'for (int i=0; i<a; ++i)' loop
function FooLoopM(a: int, b: int, i: int, c: int): int
  // Termination: the distance from i to a decreases each step
  decreases a - i
{
  if i < a then
    // Loop Body: c = c + b; ++i;
    FooLoopM(a, b, i + 1, c + b)
  else
    // Loop Exit: return c;
    c
}

// CANDIDATE

// Main entry point equivalent to int foo(int a, int b)
function Foo1(a: int, b: int): int {
  // Start loop with i = 0 and c = 1
  FooLoop1(a, b, 0, 1)
}

// Recursive helper representing the 'for (int i=0; i<a; ++i)' loop
function FooLoop1(a: int, b: int, i: int, c: int): int
  // Termination: the distance from i to a decreases each step
  decreases a - i
{
  if i < a then
    // Loop Body: c = c + b; ++i;
    FooLoop1(a, b, i + 1, c + b)
  else
    // Loop Exit: return c;
    c
}

lemma FooLoopHelper(a: int, b: int, i: int, c: int, k: int)
  ensures FooLoopM(a, b, i, c + k) == FooLoopM(a, b, i, c) + k
  decreases a - i
{
  if i < a {
    FooLoopHelper(a, b, i + 1, c + b, k);
  }
}

lemma equivalenceFooLoop(a: int, b: int, i: int, c: int)
  ensures FooLoopM(a, b, i, c) == FooLoop1(a, b, i, c)
  decreases a - i
{}

lemma equivalence(a: int, b: int)
  ensures FooM(a, b) == Foo1(a, b)
{
  FooLoopHelper(a, b, 0, 0, 1);
  equivalenceFooLoop(a, b, 0, 1);
}