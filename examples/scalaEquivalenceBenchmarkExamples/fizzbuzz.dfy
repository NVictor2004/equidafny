

































datatype List<T> = Nil | Cons(head: T, tail: List<T>)


sealed trait Outcome
case class Fizz() extends Outcome
case class Buzz() extends Outcome
case class FizzBuzz() extends Outcome
case class Number(n: int) extends Outcome

function response1(n: int): Outcome
  if n % 5 == 0 
    if n % 3 == 0  FizzBuzz()
    else Buzz()
  else if n % 3 == 0  Fizz()
  else Number(n)

function ordinalSeq1(to: int): List<int>
  requires (0 <= to)
  if to == 0  List<int>()
  else
    Cons(to, ordinalSeq1(to - 1))

function fizzBuzz1(to: int): List<Outcome>
  requires (0 <= to)
  ordinalSeq1(to).map(response1)

function fizzBuzz2(to: int): List<Outcome>
  requires (0 <= to)
  if to == 0  List<Outcome>()
  else
    if to % 15 == 0  Cons(FizzBuzz(), fizzBuzz2(to - 1))
    else
      if to % 3 == 0  Cons(Fizz(), fizzBuzz2(to - 1))
      else
        if to % 5 == 0  Cons(Buzz(), fizzBuzz2(to - 1))
        else Cons(Number(to), fizzBuzz2(to - 1))
