// MODEL

function fM(n: int): int {
  f_loopM(n, 1)
}

function f_loopM(n: int, result: int): int
{
  if n < 10 then 
    result
  else if n < 100 then 
    result + 1
  else if n < 1000 then 
    result + 2
  else if n < 10000 then 
    result + 3
  else 
    f_loopM(n / 10000, result + 4)
}

// CANDIDATE

function f1(n: int): int {
  f_loop1(n / 10, 1)
}

function f_loop1(n: int, result: int): int
{
  if n <= 0 then
    result
  else
    var n1, r1 := n / 10, result + 1;
    
    if n1 <= 0 then 
      f_loop1(n1, r1)
    else
      var n2, r2 := n1 / 10, r1 + 1;
      
      if n2 <= 0 then 
        f_loop1(n2, r2)
      else
        var n3, r3 := n2 / 10, r2 + 1;
        
        if n3 <= 0 then 
          f_loop1(n3, r3)
        else
          f_loop1(n3 / 10, r3 + 1)
}