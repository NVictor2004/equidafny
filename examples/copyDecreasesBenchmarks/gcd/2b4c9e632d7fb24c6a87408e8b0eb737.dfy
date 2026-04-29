package s13

object s13_2b4c9e632d7fb24c6a87408e8b0eb737:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a < b then gcd(b,a) else
      if b == 0 then a
      else 
        val c = a % b
        if c == 0 then b
        else gcd(b,c)

