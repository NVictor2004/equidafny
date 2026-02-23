// Based on examples from Dragana's paper

// Reference solution
function maxR(l: seq<int>): int
{
  if |l| == 0 then -1
  else if |l| == 1 then l[0]
  else
    var m := maxR(l[1..]);
    if l[0] > m then l[0] else m
}

// Defining maxC
function maxC(l: seq<int>): int
  decreases |l|
{
  if |l| == 0 then -1
  else if |l| == 1 then l[0]
  else
    var a := l[0];
    var b := l[1];
    if a > b then
      maxC([l[0]] + l[2..])
    else
      maxC(l[1..])
}

lemma maxEquivalence(l: seq<int>)
  ensures maxC(l) == maxR(l)
  decreases |l|
{}