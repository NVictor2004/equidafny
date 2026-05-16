function isEvenTopLvlM(x: int): bool
{(isEven(x) && !isOdd(x))}

function isEvenTopLvl1(x: int): bool
{(!myIsOdd(x) && myIsEven(x))}

function myIsEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x < 0) then false else if (x == 0) then true else myIsEven((x - 2))}

function myIsOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then false else if (x == 1) then true else !myIsEven((x - 1))}

function isEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x < 0) then false else if (x == 0) then true else isEven((x - 2))}

function isOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then false else if (x == 1) then true else !isEven((x - 1))}

lemma isEvenTopLvlM_isEvenTopLvl1_Equivalence(x: int)
ensures (isEvenTopLvlM(x) == isEvenTopLvl1(x))
{{isOdd_myIsOdd_Equivalence(x);match isOdd(x) {
case false =>isEven_myIsEven_Equivalence(x);
case true =>
}
}}

lemma isEven_myIsEven_Equivalence(x: int)
decreases (if (x <= 0) then 0 else x)
ensures (isEven(x) == myIsEven(x))
{{match (x < 0) {
case false =>match (x == 0) {
case false =>isEven_myIsEven_Equivalence((x - 2));
case true =>
}

case true =>
}
}}

lemma isOdd_myIsOdd_Equivalence(x: int)
decreases (if (x <= 0) then 0 else x)
ensures (isOdd(x) == myIsOdd(x))
{{match (x <= 0) {
case false =>match (x == 1) {
case false =>isEven_myIsEven_Equivalence((x - 1));
case true =>
}

case true =>
}
}}

