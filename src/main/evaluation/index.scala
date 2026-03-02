package evaluation.index

import translation.structure.* 

import evaluation.expression.evaluateBasicExpr
import evaluation.config.*

def evaluateIndex(index: Index): Int = index match {
    case ExprIndex(value) => ExprIndexCost + evaluateBasicExpr(value)
    case StartSubIndex(value) => StartSubIndexCost + evaluateBasicExpr(value)
    case UpdateIndex(left, right) =>
        UpdateIndexCost + evaluateBasicExpr(left) + evaluateBasicExpr(right)
}
