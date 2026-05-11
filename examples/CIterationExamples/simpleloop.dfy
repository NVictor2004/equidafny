// MODEL

// Main entry point
function fM(z: int): int {
  f_loopM(0) // Logic starts at i = 0
}

// Recursive helper representing the while loop
function f_loopM(i: int): int
  decreases 11 - i
{
  if i <= 10 then 
    f_loopM(i + 1) // Increment i
  else 
    i // Return current i when i > 10
}

// CANDIDATE

// The main function equivalent to int f(int z)
function f1(z: int): int {
  f_loop1(1)
}

// The recursive function implementing the while loop logic
function f_loop1(i: int): int
  decreases 11 - i
{
  if i <= 10 then 
    f_loop1(i + 1) // The "i++" step
  else 
    i // The return value when the condition (i <= 10) fails
}