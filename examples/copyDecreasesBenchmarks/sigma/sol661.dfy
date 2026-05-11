import stainless.collection._
import stainless.lang._
object C_sigma_sol661 {
  def sigma(f: BigInt => BigInt, p: BigInt, q: BigInt): BigInt = {
    if (p > q) BigInt(0)
    else if (p == q) f(p) 
    else f(p) + sigma(f, p + BigInt(1), q)
  }
}
