function fM(x: int): int
{if (x > 0) then var x := fM((x - 1));
var x := (x + 1);
if (x < 0) then 0 else x else if (x < 0) then 0 else x}

function f1(x: int): int
{if (x > 1) then var x := f1((x - 2));
var x := (x + 2);
if (x < 2) then 0 else x else if (x < 2) then 0 else x}

lemma fM_f1_Equivalence(x: int)
ensures (fM(x) == f1(x))
{{}}

