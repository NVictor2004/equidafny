// MODEL

// Main entry point equivalent to: return (double)sum / n;
function AverageM(a: seq<int>): real {
  if |a| <= 0 then 0.0
  else (SumRecursiveM(a) as real) / (|a| as real)
}

// Recursive helper to implement the loop: sum += a[i];
function SumRecursiveM(s: seq<int>): int
{
  if |s| == 0 then 0 
  else s[0] + SumRecursiveM(s[1..])
}

// CANDIDATE

// Main entry point
function Average1(a: seq<int>): real {
  if |a| <= 0 then 0.0
  else AverageRecursive1(a, |a|)
}

// Recursive helper function to handle the summation
function AverageRecursive1(s: seq<int>, n: int): real
  requires n > 0
{
  if |s| == 0 then 0.0 
  else (s[0] as real / n as real) + AverageRecursive1(s[1..], n)
}