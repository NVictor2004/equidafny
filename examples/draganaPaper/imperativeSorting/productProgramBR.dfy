
// Product programs containing isSortedRI and isSortedBI

method loopI(p: int, l: seq<int>) returns (res: bool)
  ensures res <==> ((forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1]) && (|l| > 0 ==> p <= l[0]))
{
  var currentP := p;
  var next := 0;

  while next < |l|
    invariant next <= |l|
    invariant currentP == if next == 0 then p else l[next - 1]
    invariant next > 0 ==> p <= l[0]
    invariant forall i :: 0 <= i < next - 1 ==> l[i] <= l[i+1]
  {
    if currentP > l[next] {
        return false;
    }
    currentP := l[next];
    next := next + 1;
  }

  return true;
}

method isSortedBI_RI_Equivalence(lb: seq<int>, lr: seq<int>) returns (rres: bool, bres: bool)
  requires lb == lr
  ensures rres == bres
{
  // Defining output variables
  var rout: bool;
  var bout: bool;

  // Computing isSortedRI
  if |lr| == 0 {
    rout := true;
  } else {
    var result := loopI(lr[0], lr[1..]);
    rout := result;
  }

  // Computing isSortedBI
  var index := 0;

  while index < |lb| - 1
    invariant forall i :: 0 <= i < index ==> (i < |lb| - 1 ==> lb[i] <= lb[i+1])
  {
    if lb[index] > lb[index + 1] {
        return rout, false;
    }

    index := index + 1;
  }

  bout := true;

  // Returning the results
  return rout, bout;
}

method isSortedBI_RI_Equivalence_Full(lb: seq<int>, lr: seq<int>) returns (rres: bool, bres: bool)
  requires lb == lr
  ensures rres == bres
{
  // Defining output variables
  var rout: bool;
  var bout: bool;

  // Computing isSortedRI
  if |lr| == 0 {
    rout := true;
  } else {
    var x := lr[0];
    var xs := lr[1..];

    // Computing loopI
    var currentP := x;
    var next := 0;
    var broken := false;

    while next < |xs|
      invariant next <= |xs|
      invariant currentP == if next == 0 then x else xs[next - 1]
      invariant next > 0 ==> x <= xs[0]
      invariant forall i :: 0 <= i < next - 1 ==> xs[i] <= xs[i+1]
    {
      if currentP > xs[next] {
          rout := false;
          broken := true;
          break;
      }
      currentP := xs[next];
      next := next + 1;
    }

    if !broken {
        rout := true;
    }
  }

  // Computing isSortedBI
  var index := 0;
  var broken := false;

  while index < |lb| - 1
    invariant forall i :: 0 <= i < index ==> (i < |lb| - 1 ==> lb[i] <= lb[i+1])
  {
    if lb[index] > lb[index + 1] {
        bout := false;
        broken := true;
        break;
    }
    index := index + 1;
  }

  if !broken {
    bout := true;
  }

  // Returning the results
  return rout, bout;
}