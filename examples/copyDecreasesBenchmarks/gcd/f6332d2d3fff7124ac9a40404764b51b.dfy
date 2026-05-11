package s13

import scala.annotation.tailrec

object s13_f6332d2d3fff7124ac9a40404764b51b:

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
    if b == 0 then a
    else gcd(b, a % b)
