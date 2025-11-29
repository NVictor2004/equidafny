datatype List<T> = Nil | Cons(head: T, tail: List<T>)


datatype Outcome = Fizz | Buzz | FizzBuzz | Number(n: int)

function response1(n: int): Outcome
  {if n % 5 == 0 then
    if n % 3 == 0  then FizzBuzz()
    else Buzz()
  else if n % 3 == 0  then Fizz()
  else Number(n)}

function ordinalSeq1(to: int): List<int>
  requires (0 <= to)
  {if to == 0 then Nil
  else
    Cons(to, ordinalSeq1(to - 1))}

function fizzBuzz1(to: int): List<Outcome>
  requires (0 <= to)
  {ordinalSeq1(to).map(response1)}

function fizzBuzz2(to: int): List<Outcome>
  requires (0 <= to)
  {if to == 0 then Nil
  else
    if to % 15 == 0 then Cons(FizzBuzz(), fizzBuzz2(to - 1))
    else
      if to % 3 == 0 then Cons(Fizz(), fizzBuzz2(to - 1))
      else
        if to % 5 == 0 then Cons(Buzz(), fizzBuzz2(to - 1))
        else Cons(Number(to), fizzBuzz2(to - 1))}
