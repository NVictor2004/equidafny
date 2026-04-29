package s13

object s13_8a6f2d5fe3933824a50167051bb7d5bb:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    if(a==0) then b
    else if(b == 0) then a
    else gcd(b, a%b)

      


      

