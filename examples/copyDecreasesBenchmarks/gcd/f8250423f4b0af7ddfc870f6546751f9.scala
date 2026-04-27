package s13

object s13_f8250423f4b0af7ddfc870f6546751f9:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if b == 0 then a
    else if a <= b then gcd(b,a)
    else gcd(b, a % b)
