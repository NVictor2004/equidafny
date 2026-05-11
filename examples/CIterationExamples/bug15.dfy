// MODEL

// Main entry point equivalent to int f(int z)
function fM(z: int): int {
  // Start with x = 1 as initialized in the C code
  f_loopM(1) * 2
}

// Recursive function implementing the while loop
function f_loopM(x: int): int
  requires x > 0
  decreases 10 - x
{
  if x < 10 then
    // Logic inside the loop:
    // y = 2 + x;
    // x = y + y;
    var y := 2 + x;
    f_loopM(y + y)
  else
    // Loop condition (x < 10) is false
    x
}

// CANDIDATE

// Main entry point equivalent to int f(int z)
function f1(z: int): int {
  // Start with x = 1 as initialized in the C code
  2 * f_loop1(1)
}

// Recursive function implementing the while loop
function f_loop1(x: int): int
  requires x > 0
  decreases 9 - x
{
  if x <= 9 then
    // Logic inside the loop:
    // y = 2 + x;
    // x = y + y;
    var y := x + 2;
    f_loop1(2 * y)
  else
    // Loop condition (x < 10) is false
    x
}