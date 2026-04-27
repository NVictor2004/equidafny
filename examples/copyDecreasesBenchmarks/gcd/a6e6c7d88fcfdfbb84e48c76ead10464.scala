package s13

object s13_a6e6c7d88fcfdfbb84e48c76ead10464:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a == b then a else if a < b then gcd(b,a) else
    if (a == 0) then b else if (b == 0) then a else
      val r = a%b 
      val q = (a - r)/(a/b)
      gcd(q,r)


