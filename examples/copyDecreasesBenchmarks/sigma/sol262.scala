import stainless.collection._
import stainless.lang._
object C_sigma_sol262 {
  def sigma(f: BigInt => BigInt, a: BigInt, b: BigInt): BigInt = {
    def tsigma(res: BigInt, n: BigInt): BigInt = {
      if (n > b) res else tsigma(res + f(n), n + BigInt(1))
    }
    tsigma(BigInt(0), a)
  } 
}
