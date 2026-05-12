// Times out
function rep1<A>(n: int, f: A -> A, a: A): A
  requires (n >= 0) {
  repeat1(n, f)(a)
}

function rep2<A>(n: int, f: A -> A, a: A): A
  requires (n >= 0) {
  repeat2(n, f)(a)
}

lemma equivalenceRep<A>(n: int, f: A -> A, a: A)
  requires n >= 0
  ensures rep1(n, f, a) == rep2(n, f, a)
{
  equivalenceRepeat12(n, f, a);
}

// Said to be non-equivalent, even though they are :(
function repeat1<A>(n: int, f: A -> A): A -> A
  requires (n >= 0)
  decreases(n) {
  a =>
    if (n == 0) then a
    else repeat1(n - 1, f)(f(a))
}

function repeat2<A>(n: int, f: A -> A): A -> A
  requires (n >= 0)
  decreases(n) {
  if (n == 0) then a => a
  else a => repeat2(n - 1, f)(f(a))
}

lemma equivalenceRepeat12<A>(n: int, f: A -> A, a: A)
  requires n >= 0
  ensures repeat1(n, f)(a) == repeat2(n, f)(a)
{
  if n > 0 {
    equivalenceRepeat12(n - 1, f, f(a));
  }
}
