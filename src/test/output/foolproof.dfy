datatype List<T> = Nil | Cons(head: T, tail: List<T>)

function funnyZipM(xs: List<int>, ys: List<int>): List<int>
decreases (xs)
{match (xs, ys) {
case (_, Nil) => Nil
case (Nil, _) => Nil
case (Cons(x, xs), Cons(y, ys)) => Cons(chooseM(x, y), funnyZipM(xs, ys))
}
}

function funnyZip1(xs: List<int>, ys: List<int>): List<int>
decreases (xs)
{match (xs, ys) {
case (_, Nil) => Nil
case (Nil, _) => Nil
case (Cons(x, xs), Cons(y, ys)) => Cons(choose1(x, y), funnyZip1(xs, ys))
}
}

function choose1(x: int, y: int): int
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then y else if (y <= 0) then x else choose1((x - 1), (y - 1))}

function chooseM(x: int, y: int): int
decreases (if (x <= 0) then 0 else x)
{if (x <= 0) then y else if (y <= 0) then x else chooseM((x - 1), (y - 1))}

lemma funnyZipM_funnyZip1_Equivalence(xs: List<int>, ys: List<int>)
decreases (xs)
ensures (funnyZipM(xs, ys) == funnyZip1(xs, ys))
{{match (xs, ys) {
case (_, Nil) =>
case (Nil, _) =>
case (Cons(x, xs), Cons(y, ys)) =>chooseM_choose1_Equivalence(x, y);funnyZipM_funnyZip1_Equivalence(xs, ys);
}
}}

lemma chooseM_choose1_Equivalence(x: int, y: int)
decreases (if (x <= 0) then 0 else x)
ensures (chooseM(x, y) == choose1(x, y))
{{if (x <= 0){}else {if (y <= 0){}else {chooseM_choose1_Equivalence((x - 1), (y - 1));}}}}

