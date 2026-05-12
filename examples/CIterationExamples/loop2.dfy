// MODEL

// Main entry point equivalent to int f(int n)
function fM(n: int): int {
  // Logic starts with i = 0 and j = 0
  f_loopM(n, 1, 0)
}

// Recursive helper function representing the while loop
function f_loopM(n: int, i: int, j: int): int
  // Dafny needs to know the loop terminates. 
  // Since i increases toward n, the difference (n - i) decreases.
  decreases n - i 
{
  if i <= n then
    // Logic: j = j + 2; i++;
    f_loopM(n, i + 1, j + 2)
  else
    // Loop condition (i < n) is false; return j
    j
}

// CANDIDATE

// Main entry point equivalent to int f(int n)
function f1(n: int): int {
  // Logic starts with i = 0 and j = 0
  f_loop1(n, 0, 0)
}

// Recursive helper function representing the while loop
function f_loop1(n: int, i: int, j: int): int
  // Dafny needs to know the loop terminates. 
  // Since i increases toward n, the difference (n - i) decreases.
  decreases n - i 
{
  if i < n then
    // Logic: j = j + 2; i++;
    f_loop1(n, i + 1, j + 2)
  else
    // Loop condition (i < n) is false; return j
    j
}

lemma equivalenceHelper(n: int, i: int, j: int)
  ensures f_loop1(n, i, j) == f_loopM(n, i + 1, j)
  decreases n - i
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  equivalenceHelper(n, 0, 0);
}