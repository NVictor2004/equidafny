package s13

object s13_62895dc524f43052e54d8aef568b7908:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    var first = a
    var second = b
    var temp = 0
    while true do
      if second <= 0 then return first
      else 
        temp  = first
        first = second
        second = temp % second
    first
      
