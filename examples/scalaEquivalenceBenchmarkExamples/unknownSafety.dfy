// MODEL

datatype List<T> = Nil | Cons(head: T, tail: List<T>)


function addM(x: int, y: int): int {x + y}

/////////////////////////////////////

function isEvenTopLvlM(x: int): bool {isEvenM(x)}

function isEvenM(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x < 0) then false
  else if (x == 0) then true
  else !isOddM(x - 1)
}

function isOddM(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then false
  else if (x == 1) then true
  else !isEvenM(x - 1)
}

/////////////////////////////////////

function isSortedM(xs: List<int>): bool {
  match xs {
  case Nil => true
  case Cons(_, Nil) => true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSortedM(t)
}
}

// CANDIDATE


function zero1(x: int): int
  requires (x >= 0) {
  if (x > 0) then zero1(x - 1)
  else x
}

function add1(x: int, y: int): int {
  if (x >= 0) then
    var z := zero1(x);
    assert(z == 0); // timeout
    x + y
  else
    x + y
}

/////////////////////////////////////

function isEvenTopLvl1(x: int): bool {isEven1(x)}

function isEven1(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x >= 0) then
    assert(zero1(x) == 0); // timeout
    if (x < 0) then false
    else if (x == 0) then true
    else !isOdd1(x - 1)
  else
    if (x < 0) then false
    else if (x == 0) then true
    else !isOdd1(x - 1)
}

function isOdd1(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then false
  else if (x == 1) then true
  else !isEven1(x - 1)
}

/////////////////////////////////////

function isSorted1(xs: List<int>): bool {
  match xs {
  case Nil => true
  case Cons(h, Nil) =>
    if (h >= 0) then
      assert(zero1(h) == 0); // timeout
      true
    else
      true
  case Cons(h1, Cons(h2, t)) => h1 <= h2 && isSorted1(t)
}
}


