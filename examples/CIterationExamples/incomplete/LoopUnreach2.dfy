// MODEL

function FooM(a: int, b: int): int {
  if a < 0 then 
    FooLoopM(a, b, 1, 0)
  else 
    0
}

function FooLoopM(a: int, b: int, i: int, c: int): int
  decreases b - i
{
  if i <= b then
    FooLoopM(a, b, i + 1, c + a)
  else
    c
}

// CANDIDATE

function Foo1(a: int, b: int): int {
  if a < 0 then 
    FooLoop1(a, b, 1, 0)
  else 
    0
}

function FooLoop1(a: int, b: int, i: int, c: int): int
  decreases a - i
{
  if i <= a then
    FooLoop1(a, b, i + 1, c + b)
  else
    c
}