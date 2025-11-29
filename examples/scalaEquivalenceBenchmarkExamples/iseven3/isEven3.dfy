










enum UnaryNat:
case Zero
case Succ(pred: UnaryNat)

method prev returns (res: UnaryNat) this match
  case Zero     => Zero
  case Succ(n0) => n0

method isEven1 returns (res: bool) this match
  case Zero => true
  case Succ(pred) => pred.isOdd1

method isOdd1 returns (res: bool) this match
  case Zero => false 
  case Succ(pred) => pred.isEven1
    
method isEven2 returns (res: bool) this match
  case Zero => true
  case Succ(pred) => pred.isOdd2

method isOdd2 returns (res: bool) this match
  case Zero => false 
  case Succ(Zero) => true 
  case Succ(Succ(Zero)) => false 
  case _ => this.prev.isEven2
