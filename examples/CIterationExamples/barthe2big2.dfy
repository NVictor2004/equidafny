// MODEL

function fM(n: int): int {
  // Loop 1: x = x * 1
  var x1 := MultiplicationLoop1M(n, 1, 1);
  
  // Loop 2: x = x + i
  var x2 := AdditionLoopM(n, 0, x1);
  
  // Loop 3: x = x * 2
  MultiplicationLoop2M(n, 1, x2)
}

// Equivalent to: while (i <= n) { x = x * 1; i++; }
function MultiplicationLoop1M(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then MultiplicationLoop1M(n, i + 1, x * 1) else x
}

// Equivalent to: while (i <= n) { x = x + i; i++; }
function AdditionLoopM(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then AdditionLoopM(n, i + 1, x + i) else x
}

// Equivalent to: while (i <= n) { x = x * 2; i++; }
function MultiplicationLoop2M(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then MultiplicationLoop2M(n, i + 1, x * 2) else x
}

// CANDIDATE

function f1(n: int): int {
  // Loop 1: x = x * 1
  var x1 := MultiplicationLoop11(n, 1, 1);
  
  // Loop 2: x = x + i
  var x2 := AdditionLoop1(n, 1, x1);
  
  // Loop 3: x = x * 2
  MultiplicationLoop21(n, 1, x2)
}

// Equivalent to: while (i <= n) { x = x * 1; i++; }
function MultiplicationLoop11(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then MultiplicationLoop11(n, i + 1, x * 1) else x
}

// Equivalent to: while (i <= n) { x = x + i; i++; }
function AdditionLoop1(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then AdditionLoop1(n, i + 1, x + i) else x
}

// Equivalent to: while (i <= n) { x = x * 2; i++; }
function MultiplicationLoop21(n: int, i: int, x: int): int
  decreases n - i
{
  if i <= n then MultiplicationLoop21(n, i + 1, x * 2) else x
}

lemma equivalenceMultiLoop1(n: int, i: int, x: int)
  ensures MultiplicationLoop1M(n, i, x) == MultiplicationLoop11(n, i, x)
  decreases n - i
{}

lemma equivalenceAdditionLoop(n: int, i: int, x: int)
  ensures AdditionLoopM(n, i, x) == AdditionLoop1(n, i, x)
  decreases n - i
{}

lemma equivalenceMultiLoop2(n: int, i: int, x: int)
  ensures MultiplicationLoop2M(n, i, x) == MultiplicationLoop21(n, i, x)
  decreases n - i
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  var x1 := MultiplicationLoop1M(n, 1, 1);
  var x2 := AdditionLoopM(n, 0, x1);
  equivalenceMultiLoop1(n, 1, 1);
  equivalenceAdditionLoop(n, 0, x1);
  equivalenceMultiLoop2(n, 1, x2);
}