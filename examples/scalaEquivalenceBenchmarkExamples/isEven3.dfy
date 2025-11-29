










enum UnaryNat:
case Zero
case Succ(pred: UnaryNat)

function prev: UnaryNat this match
  case Zero     => Zero
  case Succ(n0) => n0

function isEven1: bool this match
  case Zero => true
  case Succ(pred) => pred.isOdd1

function isOdd1: bool this match
  case Zero => false 
  case Succ(pred) => pred.isEven1
    
function isEven2: bool this match
  case Zero => true
  case Succ(pred) => pred.isOdd2

function isOdd2: bool this match
  case Zero => false 
  case Succ(Zero) => true 
  case Succ(Succ(Zero)) => false 
  case _ => this.prev.isEven2
