package s13

object s13_58c8a012ac15bc22ba7b4e9588539153:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a == b then a
    else if b == 0 then a
    else if a > b then gcd(a-b, b)
    else gcd(b, a)
