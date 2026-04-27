package s13

object s13_04f3cfaef7c4d9d49a7d26f5bd84ed7e:

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
    else if a < b then gcd(b,a)
    else gcd(b, a % b)
