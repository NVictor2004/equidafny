package s13

object s13_20c3f953cff937fd75a501b991e65d44:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    
    (a, b) match
      case (0, _) => b
      case (_, 0) => a
      case (_, _) => 
        if a < b then gcd(a, b-a)
        else gcd(a-b, b)
