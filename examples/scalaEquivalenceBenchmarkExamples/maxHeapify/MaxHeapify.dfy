/* Copyright 2009-2024 EPFL, Lausanne */



val MAX = 100000

method maxHeapifyM(a: Array[int], N: int, i: int): Unit =
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  decreases(N - i)
  val l = leftM(i)
  val r = rightM(i)
  val largest =
    if l < N && a(l) > a(i) 
      l
    else
      i
  val largest2 =
    if r < N && a(r) > a(largest) 
      r
    else
      largest
  if largest2 != i 
      val temp = a(i)
      a(i) = a(largest2)
      a(largest2) = temp
      maxHeapifyM(a, N, largest2)

method leftM(i: int) : int =
  requires (0 <= i && i < MAX)
  2 * i + 1

method rightM(i: int) : int =
  requires (0 <= i && i < MAX)
  2 * i + 2


method maxHeapify(a: Array[int], N: int, i: int): Unit =
  requires (i >= 0 && i < N && N <= a.length && N <= MAX)
  decreases(N - i)
  val l = 2 * i + 1
  val r = 2 * i + 2
  val largest =
    if l < N && a(l) > a(i) 
      l
    else
      i
  val largest2 =
    if r < N && a(r) > a(largest) 
      r
    else
      largest
  if largest2 != i 
    swap(i, largest2, a, N)
    maxHeapify(a, N, largest2)

method swap(a: int, b: int, array: Array[int], N: int): Unit =
  requires (a >= 0 && a < N && b >= 0 && b < N && N <= array.length && N <= MAX)
  val temp = array(a)
  array(a) = array(b)
  array(b) = temp
