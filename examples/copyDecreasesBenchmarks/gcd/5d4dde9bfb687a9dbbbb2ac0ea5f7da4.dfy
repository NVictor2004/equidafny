package s13

object s13_5d4dde9bfb687a9dbbbb2ac0ea5f7da4:

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
    else if a >= b then gcd(a-b, b)
    else gcd(b, a)
