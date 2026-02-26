// MODEL

function addM(x: int, y: int): int {x + y}

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

lemma equivalence_add(x: int, y: int)
  ensures (addM(x, y) == add1(x, y))
{}
