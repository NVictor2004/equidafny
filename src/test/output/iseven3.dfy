datatype UnaryNat = Zero | Succ(pred: UnaryNat)

function isEven1(un: UnaryNat): bool
{match un {
case Zero => true
case Succ(pred) => isOdd1(pred)
}
}

function isEven2(un: UnaryNat): bool
{match un {
case Zero => true
case Succ(pred) => isOdd2(pred)
}
}

function isOdd2(un: UnaryNat): bool
{match un {
case Zero => false
case Succ(Zero) => true
case Succ(Succ(Zero)) => false
case Succ(n) => isEven2(n)
}
}

function isOdd1(un: UnaryNat): bool
{match un {
case Zero => false
case Succ(pred) => isEven1(pred)
}
}

lemma isEven1_isEven2_Equivalence(un: UnaryNat)
ensures (isEven1(un) == isEven2(un))
{{match un {
case Zero =>
case Succ(pred) =>isOdd1_isOdd2_Equivalence(pred);
}
}}

lemma isOdd1_isOdd2_Equivalence(un: UnaryNat)
ensures (isOdd1(un) == isOdd2(un))
{{match un {
case Zero =>
case Succ(pred) =>isEven1_isEven2_Equivalence(pred);
}
}}

