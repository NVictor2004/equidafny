package evaluation.pattern

import translation.structure.*
import evaluation.expression.evaluateLiteralExpr
import evaluation.config.*

def evaluatePattern(pattern: Pattern): Double = pattern match {
  case UnNamed          => UnNamedPatternCost
  case Constant(value)  => ConstantPatternCost + evaluateLiteralExpr(value)
  case Basic(_, values) =>
    BasicPatternCost + values.map(evaluatePattern).sum
  case PatternTuple(elements) =>
    PatternTupleCost + elements.map(evaluatePattern).sum
  case PatternDatatypeConstant(_) => DatatypeConstantCost
  case PatternIdent(_) => PatternIdentCost
}
