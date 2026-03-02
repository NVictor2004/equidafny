package evaluation.config

// Cost of adding a Lemma
final val LemmaCost = 1

// Specification Costs
final val EnsuresCost = 1
final val RequiresCost = 1
final val DecreasesCost = 1

// Literal Expression Costs
final val NullLiteralCost = 1
final val RealLiteralCost = 1
final val StringLiteralCost = 1
final val IntLiteralCost = 1
final val CharLiteralCost = 1
final val BoolLiteralCost = 1

// Basic Expression Costs
final val BinaryOperatorCost = 1
final val UnaryOperatorCost = 1
final val QuantifiedCost = 1
final val IdentCost = 1
final val IdentSuffixCost = 1
final val CardinalityCost = 1
final val TupleCost = 1
final val BracketsCost = 1
final val LambdaCallCost = 1
final val LambdaCost = 1
final val SetConstructionCost = 1
final val SeqConstructionCost = 1
final val SeqIndexCost = 1

// Cost of providing a type for a variable
final val TypeCost = 1

// Costs shared between expressions and statements
final val AssertCost = 1
final val CondCost = 1
final val CallCost = 1
final val MatchCost = 1
final val LetCost = 1
final val LetOrFailCost = 1

// Pattern Costs
final val UnNamedPatternCost = 1
final val ConstantPatternCost = 1
final val BasicPatternCost = 1
final val PatternTupleCost = 1

// Index Costs
final val ExprIndexCost = 1
final val StartSubIndexCost = 1
final val UpdateIndexCost = 1
