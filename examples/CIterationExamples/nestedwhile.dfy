// MODEL

// Main entry point
function fM(x: int, g: int): int {
  f_outerM(x, g, 0)
}

// Outer loop: while (i < x)
function f_outerM(x: int, g: int, i: int): int
  decreases x - i
{
  if i < x then
    var next_i := i + 1;
    var next_g := g - 2;
    var next_g := next_g + 1;
    
    // Execute inner loop logic
    var inner_res := f_innerM(x, next_g, next_i);
    
    // Recursive call for next outer iteration
    f_outerM(inner_res.0, inner_res.1, next_i)
  else
    g
}

// Inner loop: while (x < i)
function f_innerM(x: int, g: int, i: int): (int, int)
  decreases i - x
{
  if x < i then
    var next_x := x + 2;
    var next_x := next_x - 1;
    f_innerM(next_x, g + 1, i)
  else
    (x, g)
}

// CANDIDATE

// Main entry point equivalent to int f(int x, int g)
function f1(x: int, g: int): int {
  f_outer1(x, g, 0)
}

// Recursive implementation of the outer 'while (i < x)' loop
function f_outer1(x: int, g: int, i: int): int
  decreases x - i
{
  if i < x then
    // i++; g--;
    var i_next := i + 1;
    var g_next := g - 1;
    
    // Process the inner loop: while (x < i)
    var inner_res := f_inner1(x, g_next, i_next);
    
    // Continue outer loop with updated x and g
    f_outer1(inner_res.0, inner_res.1, i_next)
  else
    g
}

// Recursive implementation of the inner 'while (x < i)' loop
// Returns (updated_x, updated_g)
function f_inner1(x: int, g: int, i: int): (int, int)
  decreases i - x
{
  if x < i then
    // x++; g++;
    f_inner1(x + 1, g + 1, i)
  else
    (x, g)
}

lemma equivalenceOuter(x: int, g: int, i: int)
  ensures f_outerM(x, g, i) == f_outer1(x, g, i)
  decreases x - i
{}

lemma equivalence(x: int, g: int)
  ensures fM(x, g) == f1(x, g)
{
  equivalenceOuter(x, g, 0);
}