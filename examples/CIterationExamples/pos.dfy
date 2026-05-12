// MODEL

// The recursive function implementing the logic of lib(int x)
function LibM(x: int): int
  // Termination: x increases toward 0. 
  // We use -x as the measure because it decreases as x gets larger.
{
  if x < 0 then
    // Loop Body: x++; counter++;
    -x
  else
    // Loop Exit: return counter (0)
    x
}

// The client function
function ClientM(x: int): int {
  if x > 0 then
    // Logic: return -lib(-x);
    -LibM(-x)
  else
    // Logic: return lib(x);
    LibM(x)
}

// CANDIDATE

// The recursive function implementing the logic of lib(int x)
function Lib1(x: int): int
  // Termination: x increases toward 0. 
  // We use -x as the measure because it decreases as x gets larger.
  decreases -x
{
  if x < 0 then
    // Loop Body: x++; counter++;
    1 + Lib1(x + 1)
  else
    // Loop Exit: return counter (0)
    0
}

// The client function
function Client1(x: int): int {
  if x > 0 then
    // Logic: return -lib(-x);
    -Lib1(-x)
  else
    // Logic: return lib(x);
    Lib1(x)
}

lemma LibEquivalence(x: int)
  requires x <= 0
  ensures LibM(x) == Lib1(x)
  decreases -x
{}

lemma equivalence(x: int)
  ensures ClientM(x) == Client1(x)
{
  if x > 0 {
    LibEquivalence(-x);
  } else {
    LibEquivalence(x);
  }
}