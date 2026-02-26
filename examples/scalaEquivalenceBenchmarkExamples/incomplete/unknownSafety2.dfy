// MODEL

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

function zero1(x: int): int
  requires (x >= 0) {
  if (x > 0) then zero1(x - 1)
  else x
}

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

lemma equivalence_isEven(x: int)
  ensures (isEvenM(x) == isEven1(x))
{
  if (x > 1) {
    equivalence_isOdd(x - 1);
  }
}

lemma equivalence_isOdd(x: int)
  ensures (isOddM(x) == isOdd1(x))
{
  if (x > 1) {
    equivalence_isEven(x - 1);
  }
}

lemma equivalence_isEvenTopLvl(x: int)
  ensures (isEvenTopLvlM(x) == isEvenTopLvl1(x))
{
  equivalence_isEven(x);
}
