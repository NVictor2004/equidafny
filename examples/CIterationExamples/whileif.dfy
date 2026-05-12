// MODEL

// Main entry point
function fM(t: int, c: int): int {
  if 0 < t then
    // Only enter the loop if t > 0
    f_loopM(c, 0)
  else
    // If t <= 0, the loop is skipped; return initial x (0)
    0
}

// Recursive helper representing the while loop
function f_loopM(c: int, x: int): int
  // Termination: c decreases toward 0 in every step
{
  if 0 < c then
    // Loop Body: x++; c = c - 1;
    f_loopM(c - 1, x + 1)
  else
    // Loop exit: return x
    x
}

// CANDIDATE

// Main entry point
function f1(t: int, c: int): int
  requires t > 0
{
  f_loop1(t, c, 0)
}

// Recursive helper representing the while loop
function f_loop1(t: int, c: int, x: int): int
  requires t > 0
{
  if 0 < c then
    // Logic: if (0 < t) { x++; c = c - 1; }
    // If t > 0, we increment x and decrement c.
    // If t <= 0 (forbidden by requires), the loop would hang.
    if 0 < t then
      f_loop1(t, c - 1, x + 1)
    else
      // This branch is logically unreachable given the requires clause
      f_loop1(t, c, x)
  else
    // Loop exit: return x
    x
}

lemma equivalenceLoop(t: int, c: int, x: int)
  requires t > 0
  ensures f_loopM(c, x) == f_loop1(t, c, x)
{}

lemma equivalence(t: int, c: int)
  requires t > 0
  ensures fM(t, c) == f1(t, c)
{
  equivalenceLoop(t, c, 0);
}