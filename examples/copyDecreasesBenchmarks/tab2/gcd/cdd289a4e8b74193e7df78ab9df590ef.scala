package s13

object s13_cdd289a4e8b74193e7df78ab9df590ef:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if b != 0 then 
      gcd(b, a%b)
    else a
      
    
