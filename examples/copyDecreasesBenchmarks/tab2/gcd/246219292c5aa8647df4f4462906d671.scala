package s13

object s13_246219292c5aa8647df4f4462906d671:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a < b then gcd(b, a)
    else {
      if b == 0 then a 
      else gcd(b, a % b)
    }
