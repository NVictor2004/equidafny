import stainless.collection._
import stainless.lang._
object C_sigma_sol655 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    b - a match {
      case i if i < BigInt(0)  => { BigInt(0) }
      case i if i == BigInt(0) => { f(a) }
      case _                   => { f(a) + sigma(f, a + BigInt(1), b) }
    }
  }
}
