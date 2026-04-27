package s13

object s13_760bfe64b85d0fcd87c954f2c8cb3c5d:

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
    if b == 0 then a
    else 
      val r = a % b
      if r == 0 then b
      else gcd(b, r)
