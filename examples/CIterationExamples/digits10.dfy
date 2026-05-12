// MODEL

// Main entry point equivalent to int f(int n)
function fM(n: int): int {
  // Logic starts with result = 1
  f_loopM(n, 1)
}

// Recursive function implementing the while loop logic
function f_loopM(n: int, result: int): int
  // Termination: n decreases toward zero whenever the 'else' branch is taken
{
  if n < 10 then 
    result
  else if n < 100 then 
    result + 1
  else if n < 1000 then 
    result + 2
  else if n < 10000 then 
    result + 3
  else 
    // The 'else' branch: n = n / 10000; result = result + 4;
    f_loopM(n / 10000, result + 4)
}

// CANDIDATE

function f1(n: int): int {
  // Initialize: result = 1; n = n / 10;
  f_loop1(n / 10, 1)
}

function f_loop1(n: int, result: int): int
  // Termination: n decreases toward 0 in every recursive step
{
  if n <= 0 then
    result
  else
    // Step 1 (corresponds to the start of the while block)
    var n1, r1 := n / 10, result + 1;
    
    if n1 <= 0 then 
      f_loop1(n1, r1)
    else
      // Step 2 (the first nested if)
      var n2, r2 := n1 / 10, r1 + 1;
      
      if n2 <= 0 then 
        f_loop1(n2, r2)
      else
        // Step 3 (the second nested if)
        var n3, r3 := n2 / 10, r2 + 1;
        
        if n3 <= 0 then 
          f_loop1(n3, r3)
        else
          // Step 4 (the third nested if)
          // After this, the while loop would repeat
          f_loop1(n3 / 10, r3 + 1)
}

lemma equivalenceHelper(n: int, result: int)
  ensures f_loopM(n, result) == f_loop1(n / 10, result)
{}

lemma equivalence(n: int)
  ensures fM(n) == f1(n)
{
  equivalenceHelper(n, 1);
}