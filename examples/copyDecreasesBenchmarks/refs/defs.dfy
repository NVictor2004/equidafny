object benchmarks_formula_defs {
  sealed abstract class Formula {
    def size: BigInt = (this match {
      case True_ => 0: BigInt
      case False_ => 0: BigInt
      case Not(p) => 1 + p.size
      case AndAlso(p0, p1) => 2 + p0.size + p1.size
      case OrElse(p0, p1) => 2 + p0.size + p1.size
      case Imply(p0, p1) => 10 + p0.size + p1.size
      case Equal(param0: Exp, param1: Exp) => 1: BigInt
    }).ensuring((r: BigInt) => r >= 0)
  }
  case object True_ extends Formula {}
  case object False_ extends Formula {}
  case class Not(param0: Formula) extends Formula {}
  case class AndAlso(param0: Formula, param1: Formula) extends Formula {}
  case class OrElse(param0: Formula, param1: Formula) extends Formula {}
  case class Imply(param0: Formula, param1: Formula) extends Formula {}
  case class Equal(param0: Exp, param1: Exp) extends Formula {}
  sealed abstract class Exp {}
  case class Num(param0: Int) extends Exp {}
  case class Plus(param0: Exp, param1: Exp) extends Exp {}
  case class Minus(param0: Exp, param1: Exp) extends Exp {}
}
