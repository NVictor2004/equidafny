// MODEL

// Main entry point
function fM(n: real): real {
  // Logic starts with i = 0.0 and j = 0.0
  f_loopM(n, 0.0, 0.0)
}

// Recursive function representing the loop
function f_loopM(n: real, i: real, j: real): real
  // We need to prove to Dafny that the loop terminates.
  // Since i increases by 1.0 each step, the distance (n - i) decreases.
  decreases n - i
{
  if i <= n then
    // Loop Body: i++; j++;
    f_loopM(n, i + 1.0, j + 1.0)
  else
    // Loop Exit: return j;
    j
}

// CANDIDATE

// Main entry point
function f1(n: real): real {
  // Logic starts with i = 0.0 and j = 0.0
  f_loop1(n, n, 0.0)
}

// Recursive function representing the loop
function f_loop1(n: real, i: real, j: real): real
  // We need to prove to Dafny that the loop terminates.
{
  if i >= 0.0 then
    // Loop Body: i++; j++;
    f_loop1(n, i - 1.0, j + 1.0)
  else
    // Loop Exit: return j;
    j
}