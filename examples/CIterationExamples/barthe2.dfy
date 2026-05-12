// MODEL

// Main entry point
function fM(n: int): int {
  // Start with i = 0 and x = 0
  f_loopM(n, 0, 0)
}

// Recursive helper representing the 'while (i <= n)' loop
function f_loopM(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then
    // Logic: x = x + i; i++;
    f_loopM(n, i + 1, x + i)
  else
    x
}

// CANDIDATE

// Main entry point
function f1(n: int): int {
  // Logic starts at j = 1 and x = 0
  f_loop1(n, 1, 0)
}

// Recursive function to handle the loop logic
function f_loop1(n: int, j: int, x: int): int
  decreases n - j
{
  if j <= n then 
    // Logic: x = x + j; j++;
    f_loop1(n, j + 1, x + j)
  else 
    x // Return x when j > n
}

lemma equivalenceHelper(n: int, i: int, x: int)
  ensures f_loopM(n, i, x) == f_loop1(n, i, x)
  decreases n - i
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  equivalenceHelper(n, 0, 0);
}
