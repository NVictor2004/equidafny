package s13

object s13_935be8ee2c74bacd1d185e724931e7ec:

  /** @param a
    *   A natural number
    * @param b
    *   A natural number
    * @return
    *   Int : The greatest common divisor between a and b
    */
  def gcd(a: Int, b: Int): Int =
    require(a >= 0 && b >= 0)
    
    var x = a
    var y = b

    while (y != 0) {
      val temp = y
      y = x % y
      x = temp
    }
    
    x
    // if a == b then a
    // else if a == 0 then b
    // else if b == 0 then a
    // else 
    //   def from(x: Int): LazyList[Int] = x #:: from(x + 1)

    //   def sieve(s: LazyList[Int]): LazyList[Int] =
    //   s match
    //     case LazyList() => LazyList()
    //     case x #:: xs => x #:: xs.filter(_ % x != 0)
      
    //   var primes = sieve(from(2)).take(Math.max(a, b) -1)

    //   var x = a
    //   var y = b
    //   var xP = primes.head
    //   var yP = primes.head
    //   var xDivs = List[Int]()
    //   var yDivs = List[Int]()
    //   var i = 0
    //   var j = 0
      
    //   var mult = List[Int]()
      
    //   println("i started")
    //   while x > 1 && y > 1 do
    //     if x % xP == 0 then
    //       xDivs = xDivs ++ List(xP)
    //       x = x / xP
    //       println(xP)
    //     else 
    //       i += 1
    //       xP = primes.drop(i).head
    //     if y % yP == 0 then
    //       yDivs = yDivs ++ List(yP)
    //       y = y / yP
    //     else 
    //       j += 1
    //       yP = primes.drop(j).head
    //   println("les primes de x sont " + xDivs)
    //   println("les primes de y sont " + yDivs)

    //   var list = {if xDivs.length > yDivs.length then xDivs else yDivs}
    //   var other = {if xDivs.length > yDivs.length then yDivs else xDivs}
    //   for z <- list
    //   yield {
    //     if other.contains(z) then
    //       mult = List(z) ++ mult
    //       list = list.tail
    //       other = other.patch(other.indexOf(z), Nil, 1)
    //   }
    //   println("la liste la plus longue est " + list)
    //   println("the other woman " + other)
    //   println("les primes communs sont " + mult)
    //   mult.foldLeft(1)(_ * _)
      
    
