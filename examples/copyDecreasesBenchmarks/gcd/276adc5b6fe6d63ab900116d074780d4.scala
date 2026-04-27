package s13

object s13_276adc5b6fe6d63ab900116d074780d4:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int = //x = yi + c
    require(a >= 0 && b >= 0)
    var x = a
    var y = b
    if a < b then 
      x = b
      y = a
    if y == 0 then x
    else
      val c = x % y
      if c == 0 then y
      else gcd(y, c)
