package s13

import stainless.lang._

object s13_2c6640c99a36d100d9148131eea05366:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if b == 0 then
      a
    else
      gcd(b, a%b)
