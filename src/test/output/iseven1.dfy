function isEvenTopLvlM(x: int): bool
{isEven(x)}

function isEvenTopLvl1(x: int): bool
{myIsEven(x)}

function myIsEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x < 0) && ((x == 0) || !myIsOdd((x - 1))))}

function myIsOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x <= 0) && ((x == 1) || !myIsEven((x - 1))))}

function isEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x < 0) && ((x == 0) || !isOdd((x - 1))))}

function isOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x <= 0) && ((x == 1) || !isEven((x - 1))))}

lemma isEvenTopLvlM_isEvenTopLvl1_Equivalence(x: int)
ensures (isEvenTopLvlM(x) == isEvenTopLvl1(x))
{{isEven_myIsEven_Equivalence(x);}}

lemma isEven_myIsEven_Equivalence(x: int)
decreases (if (x <= 0) then 0 else x)
ensures (isEven(x) == myIsEven(x))
{{}}

