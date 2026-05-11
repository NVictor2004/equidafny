datatype OpKind = Add | Sub | Mul

function evalM(op: OpKind, x: int, y: int): int
{match op {
case Add => add(x, y)
case Sub => sub(x, y)
case Mul => mul(x, y)
}
}

function eval1(op: OpKind, x: int, y: int): int
{match op {
case Sub => mySub(y, x)
case Mul => myMul(x, y)
case Add => myAdd(x, y)
}
}

function myMul(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then 0 else if (x > 0) then myAdd(myMul((x - 1), y), y) else mySub(y, myMul((x + 1), y))}

function myAdd(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then y else if (x > 0) then myAdd((x - 1), (y + 1)) else myAdd((x + 1), (y - 1))}

function mySub(x: int, y: int): int
decreases (if (y <= 0) then -y else y)
{if (y == 0) then -x else if (y > 0) then mySub((x - 1), (y - 1)) else mySub((x + 1), (y + 1))}

function mul(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then 0 else if (x > 0) then add(mul((x - 1), y), y) else sub(mul((x + 1), y), y)}

function sub(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then -y else if (x > 0) then sub((x - 1), (y - 1)) else sub((x + 1), (y + 1))}

function add(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then y else if (x > 0) then add((x - 1), (y + 1)) else add((x + 1), (y - 1))}

lemma evalM_eval1_Equivalence(op: OpKind, x: int, y: int)
ensures (evalM(op, x, y) == eval1(op, x, y))
{{match op {
case Add =>add_myAdd_Equivalence(x, y);
case Sub =>sub_mySub_Equivalence(x, y);
case Mul =>mul_myMul_Equivalence(x, y);
}
}}

lemma add_myAdd_Equivalence(x: int, y: int)
decreases (if (x <= 0) then -x else x)
ensures (add(x, y) == myAdd(x, y))
{{if (x == 0){}else {if (x > 0){add_myAdd_Equivalence((x - 1), (y + 1));}else {add_myAdd_Equivalence((x + 1), (y - 1));}}}}

lemma sub_mySub_Equivalence(x: int, y: int)
decreases (if (x <= 0) then -x else x)
ensures (sub(x, y) == mySub(y, x))
{{if (x == 0){}else {if (x > 0){sub_mySub_Equivalence((x - 1), (y - 1));}else {sub_mySub_Equivalence((x + 1), (y + 1));}}}}

lemma mul_myMul_Equivalence(x: int, y: int)
decreases (if (x <= 0) then -x else x)
ensures (mul(x, y) == myMul(x, y))
{{if (x == 0){}else {if (x > 0){mul_myMul_Equivalence((x - 1), y);add_myAdd_Equivalence(mul((x - 1), y), y);}else {sub_mySub_Equivalence(mul((x + 1), y), y);}}}}

