datatype Outcome = Fizz | Buzz | FizzBuzz | Number(n: int)

datatype List<A> = Nil | Cons(head: A, tail: List<A>)

function fizzBuzz2(to: int): List<Outcome>
requires (0 <= to)
{if to == 0 then Nil else if to % 15 == 0 then Cons(FizzBuzz(), fizzBuzz2(to - 1)) else if to % 3 == 0 then Cons(Fizz(), fizzBuzz2(to - 1)) else if to % 5 == 0 then Cons(Buzz(), fizzBuzz2(to - 1)) else Cons(Number(to), fizzBuzz2(to - 1))}

function fizzBuzz1(to: int): List<Outcome>
requires (0 <= to)
{mapf(ordinalSeq1(to), response1)}

function ordinalSeq1(to: int): List<int>
requires (0 <= to)
{if to == 0 then Nil else Cons(to, ordinalSeq1(to - 1))}

function response1(n: int): Outcome
{if n % 5 == 0 then if n % 3 == 0 then FizzBuzz() else Buzz() else if n % 3 == 0 then Fizz() else Number(n)}

function mapf<A, B>(lst: List<A>, f: (A) -> B): List<B>
{match lst {
case Nil => Nil
case Cons(h, t) => Cons(f(h), mapf(t, f))
}
}

lemma fizzBuzz2_fizzBuzz1_Equivalence(to: int)
requires (0 <= to)
ensures fizzBuzz2(to) == fizzBuzz1(to)
{{}}

