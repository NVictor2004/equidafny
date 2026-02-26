datatype List<T> = Nil | Cons(head :T, tail :List<T>)
function maxM(lst :List<int>): int
decreases (lst)
{match lst {
case Nil => -999999999999
case Cons(hd, Nil) => hd
case Cons(hd, tl) => if (hd > maxM(tl)) then hd else maxM(tl)
}
}function max5(l :List<int>): int
{-1}function max4(l :List<int>): int
decreases (l)
{match l {
case Nil => 0
case Cons(hd, tl) => if (hd > max4(tl)) then hd else max4(tl)
}
}function max3(l :List<int>): int
decreases (length(l))
{match l {
case Nil => -999999999999
case Cons(hd, tl) => match tl {
case Nil => hd
case Cons(hd1, tl1) => assert length(Cons(hd, tl1)) < length(l);
if (hd > hd1) then max3(Cons(hd, tl1)) else max3(Cons(hd1, tl1))
}

}
}function max2(l :List<int>): int
decreases (l)
{match l {
case Nil => -999999999999
case Cons(h, t) => if (h > max2(t)) then h else max2(t)
}
}function max1(l :List<int>): int
decreases (l)
{match l {
case Nil => 42
case Cons(hd, Nil) => hd
case Cons(hd, tl) => if (hd > max1(tl)) then hd else max1(tl)
}
}function length<T>(l :List<T>): nat
decreases (l)
{match l {
case Nil => 0
case Cons(_, t) => 1 + length(t)
}
}function norm(l :List<int>, f :int): int
{match l {
case Nil => -1
case _ => f
}
}lemma max5Equivalence(l :List<int>)
ensures maxM(l) == max5(l)
{{}}lemma max4Equivalence(l :List<int>)
decreases (l)
ensures maxM(l) == max4(l)
{{}}lemma max3Equivalence(l :List<int>)
decreases (length(l))
ensures maxM(l) == max3(l)
{{}}lemma max2Equivalence(l :List<int>)
decreases (l)
ensures maxM(l) == max2(l)
{{}}lemma max1Equivalence(l :List<int>)
decreases (l)
ensures maxM(l) == max1(l)
{{}}