import stainless.collection._
import stainless.lang._
object C_sigma_sol195 {
  def sigma(f: BigInt => BigInt, sn: BigInt, en: BigInt): BigInt = {
    if (sn > en) {
      BigInt(0)
    } else if (sn == en) {
      f(sn)
    } else {
      f(en) + sigma(f, sn, en - BigInt(1))
    }
  }
}
