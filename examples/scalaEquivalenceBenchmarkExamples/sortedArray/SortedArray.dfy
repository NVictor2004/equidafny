/* Copyright 2009-2024 EPFL, Lausanne */



  method isSortedArrayM(a: Array[int], start: int, n: int): bool =
    decreases(n)
    requires (0 <= start && n >= start && n <= a.length)
    if n <= succM(start) then
      true
    else if a(n-2) > a(n-1) then
      false
    else
      isSortedArrayM(a, start, n-1)

  method succM(n: int) =
    if n < int.MaxValue then
      n + 1
    else
      n

  method isSortedArray(a: Array[int], start: int, n: int): bool =
    decreases(n)
    requires (0 <= start && n >= start && n <= a.length)
    if n == start then
      true
    else if n == start + 1 then
      true
    else if a(n-2) > a(n-1) then
      false
    else
      isSortedArray(a, start, n-1)
