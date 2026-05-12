// MODEL

// Main entry point
function fM(n: int): int {
  // Normalize n: if (n < 1) n = 1;
  var actualN := if n < 1 then 1 else n;
  
  // Start loop with i = 1 and j = 2
  f_loopM(actualN, 1, 0)
}

// Recursive helper implementing the while loop
function f_loopM(n: int, i: int, j: int): int
  decreases n - i
{
  if i <= n then
    // Logic: j = j + 2; i++;
    f_loopM(n, i + 1, j + 2)
  else
    // Loop exit: return j
    j
}

// CANDIDATE

// Main entry point
function f1(n: int): int {
  // Normalize n: if (n < 1) n = 1;
  var actualN := if n < 1 then 1 else n;
  
  // Start loop with i = 1 and j = 2
  f_loop1(actualN, 1, 2)
}

// Recursive helper implementing the while loop
function f_loop1(n: int, i: int, j: int): int
  decreases n - i
{
  if i < n then
    // Logic: j = j + 2; i++;
    f_loop1(n, i + 1, j + 2)
  else
    // Loop exit: return j
    j
}