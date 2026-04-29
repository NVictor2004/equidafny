import stainless.collection._
import stainless.lang._
object C_sigma_sol585 {
  def sigma(test: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    if (a > b) BigInt(0)
    else if (a == b) test(a) 
    else test(b) + sigma(test, a, b - BigInt(1))
  }
}
