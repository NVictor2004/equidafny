










datatype List<T> = Nil | Cons(head: T, tail: List<T>)


sealed trait Outcome
case class Fizz() extends Outcome
case class Buzz() extends Outcome
case class FizzBuzz() extends Outcome
case class Number(n: int) extends Outcome

method response1(n: int) returns (res: Outcome)
  if n % 5 == 0 
    if n % 3 == 0  FizzBuzz()
    else { var result := Buzz(); return result; }
  else { var result := if n % 3 == 0  Fizz(); return result; }
  else { var result := Number(n); return result; }

method ordinalSeq1(to: int) returns (res: List<int>)
  requires (0 <= to)
  if to == 0  List<int>()
  else
    Cons(to, ordinalSeq1(to - 1))

method fizzBuzz1(to: int) returns (res: List<Outcome>)
  requires (0 <= to)
  ordinalSeq1(to).map(response1)

method fizzBuzz2(to: int) returns (res: List<Outcome>)
  requires (0 <= to)
  if to == 0  List<Outcome>()
  else
    if to % 15 == 0  Cons(FizzBuzz(), fizzBuzz2(to - 1))
    else
      if to % 3 == 0  Cons(Fizz(), fizzBuzz2(to - 1))
      else
        if to % 5 == 0  Cons(Buzz(), fizzBuzz2(to - 1))
        else { var result := Cons(Number(to), fizzBuzz2(to - 1)); return result; }
