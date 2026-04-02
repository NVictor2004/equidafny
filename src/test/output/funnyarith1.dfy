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
case Sub => mySub(x, y)
case Mul => myMul(x, y)
case Add => myAdd(x, y)
}
}

function myMul(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then 0 else if (x > 0) then myAdd(myMul((x - 1), y), y) else mySub(myMul((x + 1), y), y)}

function myAdd(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then y else if (x > 0) then myAdd((x - 1), (y + 1)) else myAdd((x + 1), (y - 1))}

function mySub(x: int, y: int): int
decreases (if (x <= 0) then -x else x)
{if (x == 0) then -y else if (x > 0) then mySub((x - 1), (y - 1)) else mySub((x + 1), (y + 1))}

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
{{}}

