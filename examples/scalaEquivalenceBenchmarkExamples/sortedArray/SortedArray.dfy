/* Copyright 2009-2024 EPFL, Lausanne */



method isSortedArrayM(a: seq<int>, start: int, n: int) returns (res: bool)
  decreases(n)
  requires (0 <= start && n >= start && n <= a.length)
  if n <= succM(start) 
    true
  else if a(n-2) > a(n-1) 
    false
  else
    isSortedArrayM(a, start, n-1)

method succM(n: int) =
  if n < int.MaxValue 
    n + 1
  else
    n

method isSortedArray(a: seq<int>, start: int, n: int) returns (res: bool)
  decreases(n)
  requires (0 <= start && n >= start && n <= a.length)
  if n == start 
    true
  else if n == start + 1 
    true
  else if a(n-2) > a(n-1) 
    false
  else
    isSortedArray(a, start, n-1)
