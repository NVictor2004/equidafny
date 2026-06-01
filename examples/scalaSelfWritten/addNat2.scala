object addNat2 {
  
  datatype Nat = Zero | Succ(n: Nat)
  
  def addHelperM(n: Nat, m: Nat): Nat {
      n match {
          case Zero => m
          case Succ(n') => Succ(addHelperM(n', m))
      }
  }
  
  def addHelper1(n: Nat, m: Nat): Nat {
      n match {
          case Zero => m
          case Succ(n') => Succ(addHelper1(n', m))
      }
  }
  
  def addM(n: Nat, m: Nat): Nat {
      addHelperM(n, m)
  }
  
  def add1(n: Nat, m: Nat): Nat {
      addHelper1(m, n)
  }
}
