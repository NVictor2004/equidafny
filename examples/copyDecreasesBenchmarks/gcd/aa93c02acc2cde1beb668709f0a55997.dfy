package s13

object s13_aa93c02acc2cde1beb668709f0a55997:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if a < b then 
      gcd(b, a) 
    else if b == 0 then 
      a 
    else
      gcd(b, a % b)
