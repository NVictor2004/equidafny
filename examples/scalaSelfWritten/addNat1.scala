object addNat1 {
  
  datatype Nat = Zero | Succ(n: Nat)
  
  def addHelper(n: Nat, m: Nat): Nat {
      match n {
          case Zero => m
          case Succ(n') => Succ(addHelper(n', m))
      }
  }
  
  def addM(n: Nat, m: Nat): Nat {
      addHelper(n, m)
  }
  
  def add1(n: Nat, m: Nat): Nat {
      addHelper(m, n)
  }
}
