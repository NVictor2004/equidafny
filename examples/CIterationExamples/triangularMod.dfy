// MODEL

// Equivalent to int tr(int n)
// Assuming the intended logic included i++
function TrM(n: int): int {
  TrLoopM(n, 0, 0)
}

// Recursive helper for the while loop in tr
function TrLoopM(n: int, i: int, result: int): int
  // Termination proof: i increases toward n
  decreases n - i
{
  if i < n then
    // Logic: result = result + i; i++; (Assumed)
    TrLoopM(n, i + 1, result + i)
  else
    result
}

// Equivalent to int f(int m)
function FM(m: int): int {
  if m > 0 then
    var res := TrM(m - 1);
    if res >= 0 then res + m
    else res
  else
    0
}

// CANDIDATE

// Equivalent to int tr(int n)
// Assuming the intended logic included i++
function Tr1(n: int): int {
  TrLoop1(n, 0, 0)
}

// Recursive helper for the while loop in tr
function TrLoop1(n: int, i: int, result: int): int
  // Termination proof: i increases toward n
  decreases n - i
{
  if i < n then
    // Logic: result = result + i; i++; (Assumed)
    TrLoop1(n, i + 1, result + i)
  else
    result
}

// Equivalent to int f(int m)
function F1(m: int): int {
  if m > 0 then
    var res := Tr1(m - 1);
    res + m 
  else
    0
}