function isEvenTopLvlM(x: int): bool
{(isEven(x) && !isOdd(x))}

function isEvenTopLvl1(x: int): bool
{(!myIsOdd(x) && myIsEven(x))}

function myIsEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x < 0) && ((x == 0) || myIsEven((x - 2))))}

function myIsOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x <= 0) && ((x == 1) || !myIsEven((x - 1))))}

function isEven(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x < 0) && ((x == 0) || isEven((x - 2))))}

function isOdd(x: int): bool
decreases (if (x <= 0) then 0 else x)
{(!(x <= 0) && ((x == 1) || !isEven((x - 1))))}

lemma isEvenTopLvlM_isEvenTopLvl1_Equivalence(x: int)
ensures (isEvenTopLvlM(x) == isEvenTopLvl1(x))
{{}}

