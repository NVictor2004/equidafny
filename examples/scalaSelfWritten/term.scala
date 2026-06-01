object term {
  datatype Term = Val(v: int) | UMinus(t: Term) | Mult(left: Term, right: Term)
  
  def eval(t: Term): int {
      t match {
          case Val(v) => v
          case UMinus(t) => -eval(t)
          case Mult(left, right) => eval(left) * eval(right)
      }
  }
  
  def rip(t: Term): Term {
      t match {
          case Val(v) => Val(v)
          case UMinus(t) => rip(t)
          case Mult(left, right) => Mult(rip(left), rip(right))
      }
  }
  
  def pos(t: Term): bool {
      t match {
          case Val(v) => true
          case UMinus(t) => !pos(t)
          case Mult(left, right) => pos(left) == pos(right)
      }
  }
  
  def wSign(i: int, b: bool): int {
      if b then i else -i
  }
  
  def evalM(t: Term): int {
      eval(t)
  }
  
  def eval1(t: Term): int {
      wSign(eval(rip(t)), pos(t)) 
  }
  
  lemma equivalence(t: Term)
      ensures evalM(t) == eval1(t)
  {
      t match {
          case Val(v) => {}
          case UMinus(expr) => equivalence(expr);
          case Mult(left, right) => {
              equivalence(left);
              equivalence(right);
          }
      }
  }
}
