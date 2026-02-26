function andThen1<A, B, C>(f: A -> B, g: B -> C): A -> C { a => g(f(a)) }
function andThen2<A, B, C>(ff: A -> B, gg: B -> C): A -> C { aa => gg(ff(aa)) }

function compose1<A, B, C>(f: B -> C, g: A -> B): A -> C { a => f(g(a)) }
function compose2<A, B, C>(ff: B -> C, gg: A -> B): A -> C { aa => ff(gg(aa)) }

function flip1<A, B, C>(f: (A, B) -> C): (B, A) -> C { (b, a) => f(a, b) }
function flip2<A, B, C>(f: (A, B) -> C): (B, A) -> C { (b, a) => var res := f(a, b); res }

function curry1<A, B, C>(f: (A, B) -> C): A -> B -> C { a => b => f(a, b) }
function curry2<A, B, C>(f: (A, B) -> C): A -> B -> C { aa => bb => var res := f(aa, bb); res }

function uncurry1<A, B, C>(f: A -> B -> C): (A, B) -> C { (a, b) => f(a)(b) }
function uncurry2<A, B, C>(f: A -> B -> C): (A, B) -> C { (a, b) => var res := f(a)(b); res }

lemma equivalenceAndThen<A, B, C>(f: A -> B, g: B -> C)
  ensures andThen1(f, g) == andThen2(f, g)
{}

lemma equivalenceCompose<A, B, C>(f: B -> C, g: A -> B)
  ensures compose1(f, g) == compose2(f, g)
{}

// Dafny cannot prove this lemma
lemma equivalenceFlip<A, B, C>(f: (A, B) -> C)
  ensures flip1(f) == flip2(f)
{}

lemma equivalenceCurry<A, B, C>(f: (A, B) -> C)
  ensures (curry1(f) == curry2(f))
{}

lemma equivalenceUncurry<A, B, C>(f: A -> B -> C)
  ensures (uncurry1(f) == uncurry2(f))
{}

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
  requires (n >= 0)
  ensures (rep1(n, f, a) == rep2(n, f, a))
{
  equivalenceRepeat12(n, f);
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

lemma equivalenceRepeat12<A>(n: int, f: A -> A)
  requires (n >= 0)
  ensures (repeat1(n, f) == repeat2(n, f))
{
  assert forall a: A :: repeat1(n, f)(a) == repeat2(n, f)(a);
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
