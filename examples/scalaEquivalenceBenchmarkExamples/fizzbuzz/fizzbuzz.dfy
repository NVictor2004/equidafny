

  sealed trait Outcome
  case class Fizz() extends Outcome
  case class Buzz() extends Outcome
  case class FizzBuzz() extends Outcome
  case class Number(n: int) extends Outcome

  method response1(n: int): Outcome =
    if n % 5 == 0 then
      if n % 3 == 0 then FizzBuzz()
      else Buzz()
    else if n % 3 == 0 then Fizz()
    else Number(n)

  method ordinalSeq1(to: int): List[int] =
    require(0 <= to)
    if to == 0 then List[int]()
    else
      Cons(to, ordinalSeq1(to - 1))

  method fizzBuzz1(to: int): List[Outcome] =
    require(0 <= to)
    ordinalSeq1(to).map(response1)

  method fizzBuzz2(to: int): List[Outcome] =
    require(0 <= to)
    if to == 0 then List[Outcome]()
    else
      if to % 15 == 0 then Cons(FizzBuzz(), fizzBuzz2(to - 1))
      else
        if to % 3 == 0 then Cons(Fizz(), fizzBuzz2(to - 1))
        else
          if to % 5 == 0 then Cons(Buzz(), fizzBuzz2(to - 1))
          else Cons(Number(to), fizzBuzz2(to - 1))
