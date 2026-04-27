import stainless.collection._
import stainless.lang._
object C_sigma_sol452 {
  def sigma(f: BigInt => BigInt, beg: BigInt, fin: BigInt): BigInt = {
    if (beg > fin) BigInt(0) else f(beg) + sigma(f, beg + BigInt(1), fin)
  }
}
