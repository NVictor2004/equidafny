// MODEL

function TrM(n: int): int {
  TrLoopM(n, 0, 0)
}

function TrLoopM(n: int, i: int, result: int): int
  decreases n - i
{
  if i < n then
    TrLoopM(n, i + 1, result + i)
  else
    result
}

function FM(m: int): int {
  if m > 0 then
    var res := TrM(m - 1);
    if res >= 0 then res + m
    else res
  else
    0
}

// CANDIDATE

function Tr1(n: int): int {
  TrLoop1(n, 0, 0)
}

function TrLoop1(n: int, i: int, result: int): int
  decreases n - i
{
  if i < n then
    TrLoop1(n, i + 1, result + i)
  else
    result
}

function F1(m: int): int {
  if m > 0 then
    var res := Tr1(m - 1);
    res + m 
  else
    0
}

lemma equivalenceTrLoop(n: int, i: int, result: int)
  ensures TrLoopM(n, i, result) == TrLoop1(n, i, result)
  decreases n - i
{}

lemma TrLoopNonNegative(n: int, i: int, res: int)
  requires res >= 0 && i >= 0
  ensures TrLoopM(n, i, res) >= 0
  decreases n - i
{}

lemma equivalence(m: int)
  ensures FM(m) == F1(m)
{
  if m > 0 {
    equivalenceTrLoop(m - 1, 0, 0); 
    TrLoopNonNegative(m - 1, 0, 0);
  }
}