// MODEL

function FooM(a: int, b: int): int {
  FooLoopM(a, b, 0, 0) + 1
}

function FooLoopM(a: int, b: int, i: int, c: int): int
  decreases a - i
{
  if i < a then
    FooLoopM(a, b, i + 1, c + b)
  else
    c
}

// CANDIDATE

function Foo1(a: int, b: int): int {
  FooLoop1(a, b, 0, 1)
}

function FooLoop1(a: int, b: int, i: int, c: int): int
  decreases a - i
{
  if i < a then
    FooLoop1(a, b, i + 1, c + b)
  else
    c
}

lemma FooLoopHelper(a: int, b: int, i: int, c: int, k: int)
  ensures FooLoopM(a, b, i, c + k) == FooLoopM(a, b, i, c) + k
  decreases a - i
{
  if i < a {
    FooLoopHelper(a, b, i + 1, c + b, k);
  }
}

lemma equivalenceFooLoop(a: int, b: int, i: int, c: int)
  ensures FooLoopM(a, b, i, c) == FooLoop1(a, b, i, c)
  decreases a - i
{}

lemma equivalence(a: int, b: int)
  ensures FooM(a, b) == Foo1(a, b)
{
  FooLoopHelper(a, b, 0, 0, 1);
  equivalenceFooLoop(a, b, 0, 1);
}