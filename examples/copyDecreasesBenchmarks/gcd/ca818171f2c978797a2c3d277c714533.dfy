package s13

object s13_ca818171f2c978797a2c3d277c714533:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    b match
      case 0 => a
      case _  => gcd(b, a % b)
    