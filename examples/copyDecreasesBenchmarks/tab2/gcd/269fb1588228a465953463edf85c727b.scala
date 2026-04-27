package s13

import scala.annotation.tailrec

object s13_269fb1588228a465953463edf85c727b:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  @tailrec
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a < b then gcd(b, a)
    else {
      if b == 0 then a 
      else gcd(b, a % b)
    }
