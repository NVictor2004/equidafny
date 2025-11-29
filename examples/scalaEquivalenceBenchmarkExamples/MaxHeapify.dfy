










/* Copyright 2009-2024 EPFL, Lausanne */



var MAX := 100000;

method maxHeapifyM(a: seq<int>, N: int, i: int) returns (res: Unit)
  requires (i >= 0 && i < N && N <= |a| && N <= MAX)
  decreases(N - i) {
  var l := leftM(i);
  var r := rightM(i);
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
      var temp := a(i);
      a(i) = a(largest2)
      a(largest2) = temp
      maxHeapifyM(a, N, largest2)

method leftM(i: int)  returns (res: int)
  requires (0 <= i && i < MAX)
  2 * i + 1

method rightM(i: int)  returns (res: int)
  requires (0 <= i && i < MAX)
  2 * i + 2


method maxHeapify(a: seq<int>, N: int, i: int) returns (res: Unit)
  requires (i >= 0 && i < N && N <= |a| && N <= MAX)
  decreases(N - i) {
  var l := 2 * i + 1;
  var r := 2 * i + 2;
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

method swap(a: int, b: int, array: seq<int>, N: int) returns (res: Unit)
  requires (a >= 0 && a < N && b >= 0 && b < N && N <= |array| && N <= MAX)
  var temp := array(a);
  array(a) = array(b)
  array(b) = temp
