

































datatype UnaryNat = Zero | Succ(pred: UnaryNat)

function prev(un: UnaryNat): UnaryNat {
  match un
  case Zero     => Zero
  case Succ(n0) => n0
}

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
  case _ => isEven2(prev(un))
}
