package translation.structure

// The Pattern data structure is used for pattern matching in match expressions
sealed trait Pattern
object UnNamed extends Pattern
case class Constant(value: LiteralExpr) extends Pattern
case class PatternIdent(value: String) extends Pattern
case class Basic(name: String, values: List[Pattern]) extends Pattern
case class PatternTuple(elements: List[Pattern]) extends Pattern
