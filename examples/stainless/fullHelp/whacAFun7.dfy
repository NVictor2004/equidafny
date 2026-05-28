function repeat1<A>(n: int, f: A -> A): A -> A
  requires (n >= 0)
  decreases(n) {
  a =>
    if (n == 0) then a
    else repeat1(n - 1, f)(f(a))
}

function repeat3<A>(n: int, f: A -> A): A -> A
  requires (n >= 0)
  decreases(n) {
  a =>
    if (n == 0) then a
    else
      var fa := f(a);
      repeat1(n - 1, f)(fa)
}

lemma equivalenceRepeat13<A>(n: int, f: A -> A)
  requires (n >= 0)
  ensures (repeat1(n, f) == repeat3(n, f))
{
  assert forall a: A :: repeat1(n, f)(a) == repeat3(n, f)(a);
}
