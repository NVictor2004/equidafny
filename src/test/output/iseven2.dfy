function isEvenTopLvlM(x :int): bool
{isEven(x) && !isOdd(x)}function isEvenTopLvl1(x :int): bool
{!myIsOdd(x) && myIsEven(x)}function myIsEven(x :int): bool
decreases (if (x <= 0) then 0 else x)
{if (x < 0) then false else if (x == 0) then true else myIsEven(x - 2)}function myIsOdd(x :int): bool
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then false else if (x == 1) then true else !myIsEven(x - 1)}function isEven(x :int): bool
decreases (if (x <= 0) then 0 else x)
{if (x < 0) then false else if (x == 0) then true else isEven(x - 2)}function isOdd(x :int): bool
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then false else if (x == 1) then true else !isEven(x - 1)}lemma isEvenTopLvl1Equivalence(x :int)
ensures isEvenTopLvlM(x) == isEvenTopLvl1(x)
{{}}