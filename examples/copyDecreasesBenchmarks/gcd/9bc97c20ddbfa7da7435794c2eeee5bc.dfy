package s13

object s13_9bc97c20ddbfa7da7435794c2eeee5bc:

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
    else if a >= b then gcd(a%b, b)
    else gcd(b, a)
