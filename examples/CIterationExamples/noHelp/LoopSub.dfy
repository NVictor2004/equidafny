// MODEL

function FooM(a: int, b: int): int {
  FooLoopM(b, 0, a)
}

function FooLoopM(b: int, i: int, c: int): int
  decreases 3 - i
{
  if i < 3 then
    FooLoopM(b, i + 1, c - b)
  else
    c
}

// CANDIDATE

function Foo1(a: int, b: int): int {
  FooLoop1(a, 0, b)
}

function FooLoop1(a: int, i: int, c: int): int
  decreases 3 - i
{
  if i < 3 then
    FooLoop1(a, i + 1, c - a)
  else
    c
}