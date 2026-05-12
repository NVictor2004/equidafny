// MODEL

// Main entry point equivalent to int foo(int a, int b)
function FooM(a: int, b: int): int {
  // Start loop with i = 0 and c = a
  FooLoopM(b, 0, a)
}

// Recursive helper representing the 'for (int i=0; i<3; ++i)' loop
function FooLoopM(b: int, i: int, c: int): int
  // Termination: i increases towards 3
  decreases 3 - i
{
  if i < 3 then
    // Logic: c -= b; ++i;
    FooLoopM(b, i + 1, c - b)
  else
    // Loop exit: return c;
    c
}

// CANDIDATE

// Main entry point equivalent to int foo(int a, int b)
function Foo1(a: int, b: int): int {
  // Start loop with i = 0 and c = a
  FooLoop1(a, 0, b)
}

// Recursive helper representing the 'for (int i=0; i<3; ++i)' loop
function FooLoop1(a: int, i: int, c: int): int
  // Termination: i increases towards 3
  decreases 3 - i
{
  if i < 3 then
    // Logic: c -= b; ++i;
    FooLoop1(a, i + 1, c - a)
  else
    // Loop exit: return c;
    c
}