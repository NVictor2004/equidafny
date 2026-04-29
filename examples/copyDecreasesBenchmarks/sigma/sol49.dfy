import stainless.collection._
import stainless.lang._
object C_sigma_sol49 {
  sealed case class Invalid_Input() extends Exception {}
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def iter(n: BigInt): BigInt = {
      if (n > b) BigInt(0)
      else if (n == b) f(n) 
      else f(n) + iter(n + BigInt(1))
    }
    if (a > b) BigInt(0) else iter(a)
  }
}
