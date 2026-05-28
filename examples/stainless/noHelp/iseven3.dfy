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
