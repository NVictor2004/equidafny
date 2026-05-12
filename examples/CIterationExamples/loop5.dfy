// MODEL

// Main entry point
function fM(n: int): int {
  // Pre-loop logic: i = n + n; j = 0;
  f_loopM(n, 0, 0)
}

// Recursive helper representing 'while (i > 0)'
function f_loopM(n: int, i: int, j: int): int
  // Dafny requires a termination proof. 
  // Since i decreases by 1 each step, we use i as the measure.
  decreases n + n - i
{
  if i < n + n then
    // Loop Body: j++; i = i - 1;
    f_loopM(n, i + 1, j + 1)
  else
    // Loop Exit: return j;
    j
}

// CANDIDATE

// Main entry point
function f1(n: int): int {
  // Pre-loop logic: i = n + n; j = 0;
  f_loop1(n + n, 0)
}

// Recursive helper representing 'while (i > 0)'
function f_loop1(i: int, j: int): int
  // Dafny requires a termination proof. 
  // Since i decreases by 1 each step, we use i as the measure.
{
  if i > 0 then
    // Loop Body: j++; i = i - 1;
    f_loop1(i - 1, j + 1)
  else
    // Loop Exit: return j;
    j
}