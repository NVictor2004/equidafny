datatype UnaryNat = Zero | Succ(pred: UnaryNat)

function isEven1(un: UnaryNat): bool {
  match un
  case Zero => true
  case Succ(pred) => isOdd1(pred)
}

function isOdd1(un: UnaryNat): bool {
  match un
  case Zero => false 
  case Succ(pred) => isEven1(pred)
}
    
function isEven2(un: UnaryNat): bool {
  match un
  case Zero => true
  case Succ(pred) => isOdd2(pred)
}

function isOdd2(un: UnaryNat): bool {
  match un
  case Zero => false 
  case Succ(Zero) => true 
  case Succ(Succ(Zero)) => false 
  case Succ(n) => isEven2(n)
}

lemma equivalenceIsEven(un: UnaryNat)
  ensures (isEven1(un) == isEven2(un))
{
  match un
  case Zero => {}
  case Succ(n) => equivalenceIsOdd(n);
}

lemma equivalenceIsOdd(un: UnaryNat)
  ensures (isOdd1(un) == isOdd2(un))
{
  match un
  case Zero => {}
  case Succ(n) => equivalenceIsEven(n);
}
