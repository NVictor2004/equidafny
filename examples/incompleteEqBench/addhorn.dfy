// MODEL

function fM(i: int, j: int): int
{
  if (i == 0) then
    j
  else
    fM(i - 1, j + 1)
  }

// CANDIDATE

function f1(i: int, j: int): int
{
  if (i == 0) then
    j
  else
    if (i == 1) then
      j + 1
    else
      f1(i - 1, j + 1)
    }
