package s13

object s13_21ad93f07ca8f41ee7f31f4f97ad5152:

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
    else if b == 0 then a
    else gcd(b, a%b)

