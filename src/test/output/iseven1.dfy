function isEvenTopLvlM(x: int): bool
{isEven(x)}

function isEvenTopLvl1(x: int): bool
{myIsEven(x)}

function myIsEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x < 0) then false else if (x == 0) then true else !myIsOdd((x - 1))}

function myIsOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then false else if (x == 1) then true else !myIsEven((x - 1))}

function isEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x < 0) then false else if (x == 0) then true else !isOdd((x - 1))}

function isOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then false else if (x == 1) then true else !isEven((x - 1))}

lemma isEvenTopLvlM_isEvenTopLvl1_Equivalence(x: int)
ensures (isEvenTopLvlM(x) == isEvenTopLvl1(x))
{{isEven_myIsEven_Equivalence(x);}}

lemma isEven_myIsEven_Equivalence(x: int)
decreases (if (x <= 0) then 0 else x)
ensures (isEven(x) == myIsEven(x))
{{if (x < 0){}else {if (x == 0){}else {isOdd_myIsOdd_Equivalence((x - 1));}}}}

lemma isOdd_myIsOdd_Equivalence(x: int)
decreases (if (x <= 0) then 0 else x)
ensures (isOdd(x) == myIsOdd(x))
{{if (x <= 0){}else {if (x == 1){}else {isEven_myIsEven_Equivalence((x - 1));}}}}

