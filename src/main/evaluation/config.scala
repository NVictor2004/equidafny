package evaluation.config

// Cost of adding a Lemma
final val LemmaCost = 1.0

// Specification Costs
final val EnsuresCost = 1.0
final val RequiresCost = 1.0
final val DecreasesCost = 1.0

// Literal Expression Costs
final val NullLiteralCost = 1.0
final val RealLiteralCost = 1.0
final val StringLiteralCost = 1.0
final val IntLiteralCost = 1.0
final val CharLiteralCost = 1.0
final val BoolLiteralCost = 1.0

// Basic Expression Costs
final val BinaryOperatorCost = 1.0
final val UnaryOperatorCost = 1.0
final val QuantifiedCost = 1.0
final val IdentCost = 1.0
final val IdentSuffixCost = 1.0
final val CardinalityCost = 1.0
final val TupleCost = 1.0
final val BracketsCost = 1.0
final val LambdaCallCost = 1.0
final val LambdaCost = 1.0
final val SetConstructionCost = 1.0
final val SeqConstructionCost = 1.0
final val SeqIndexCost = 1.0
final val TupleExtractionCost = 1.0
final val TypeCastCost = 1.0

// Cost of providing a type for a variable
final val TypeCost = 1.0

// Costs shared between expressions and statements
final val AssertCost = 1.0
final val CondCost = 1.0
final val CallCost = 1.0
final val MatchCost = 1.0
final val LetCost = 1.0
final val LetOrFailCost = 1.0

// Pattern Costs
final val UnNamedPatternCost = 1.0
final val ConstantPatternCost = 1.0
final val BasicPatternCost = 1.0
final val PatternTupleCost = 1.0
final val PatternIdentCost = 1.0

// Index Costs
final val ExprIndexCost = 1.0
final val StartSubIndexCost = 1.0
final val UpdateIndexCost = 1.0
