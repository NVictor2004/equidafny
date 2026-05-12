// MODEL

// Main entry point equivalent to int foo(int a, int b)
function FooM(a: int, b: int): int {
  // Start loop with i = 1 and c = 0
  FooLoopM(a, b, 1, 0)
}

// Recursive helper representing the for-loop
function FooLoopM(a: int, b: int, i: int, c: int): int
  // Termination: The distance from i to a decreases with each call
  decreases b - i
{
  if i <= b then
    // Logic: c += b; i++;
    FooLoopM(a, b, i + 1, c + a)
  else
    // Loop exit: return c;
    c
}

// CANDIDATE

// Main entry point equivalent to int foo(int a, int b)
function Foo1(a: int, b: int): int {
  // Start loop with i = 1 and c = 0
  FooLoop1(a, b, 1, 0)
}

// Recursive helper representing the for-loop
function FooLoop1(a: int, b: int, i: int, c: int): int
  // Termination: The distance from i to a decreases with each call
  decreases a - i
{
  if i <= a then
    // Logic: c += b; i++;
    FooLoop1(a, b, i + 1, c + b)
  else
    // Loop exit: return c;
    c
}