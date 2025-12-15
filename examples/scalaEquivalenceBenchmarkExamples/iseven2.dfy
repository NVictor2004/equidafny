// MODEL

function isEvenTopLvlM(x: int): bool {isEven(x) && !isOdd(x)} // calls isEven and isOdd to force matching for both of them

function isOdd(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then false
  else if (x == 1) then true
  else !isEven(x - 1)
}
function isEven(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x < 0) then false
  else if (x == 0) then true
  else isEven(x - 2)
}

// CANDIDATE

function isEvenTopLvl1(x: int): bool {!myIsOdd(x) && myIsEven(x)} // Note: swapped order to cause "pairs" to be mismatched

function myIsOdd(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x <= 0) then false
  else if (x == 1) then true
  else !myIsEven(x - 1)
}
function myIsEven(x: int): bool
  decreases(if (x <= 0) then 0 else x) {
  if (x < 0) then false
  else if (x == 0) then true
  else myIsEven(x - 2)
}

lemma equivalenceIsOdd(x: int)
  decreases(if (x <= 0) then 0 else x)
  ensures (isOdd(x) == myIsOdd(x))
{
  if (x >= 1) {equivalenceIsEven(x - 1);}
}

lemma equivalenceIsEven(x: int)
  decreases(if (x <= 0) then 0 else x)
  ensures (isEven(x) == myIsEven(x))
{
  if (x >= 1) {equivalenceIsOdd(x - 1);}
}

lemma equivalenceIsEvenTopLvl(x: int)
  ensures (isEvenTopLvlM(x) == isEvenTopLvl1(x))
{
  equivalenceIsOdd(x);
  equivalenceIsEven(x);
}
