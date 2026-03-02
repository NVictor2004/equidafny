package evaluation.specification

import translation.structure.*

import evaluation.config.*
import evaluation.expression.evaluateBasicExpr

def evaluateSpec(spec: Spec): Int = spec match {
  case Ensures(e)    => EnsuresCost + evaluateBasicExpr(e)
  case Requires(e)   => RequiresCost + evaluateBasicExpr(e)
  case Decreases(es) => DecreasesCost + es.map(evaluateBasicExpr).sum
}
