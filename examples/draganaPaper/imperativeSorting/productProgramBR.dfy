
// Product programs containing isSortedRI and isSortedBI

method loopI(p: int, l: seq<int>) returns (res: bool)
  ensures res <==> ((forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1]) && (|l| > 0 ==> p <= l[0]))
{
  var currentP := p;
  var currentL := l;

  while true
    decreases |currentL|
    invariant currentL == l[|l| - |currentL| .. ]
    invariant currentP == if |l| == |currentL| then p else l[|l| - |currentL| - 1]
    invariant |l| > |currentL| ==> p <= l[0]
    invariant forall i :: 0 <= i < |l| - |currentL| - 1 ==> l[i] <= l[i+1]
  {
    if |currentL| == 0 {
      return true;
    } else {
      if currentP > currentL[0] {
        return false;
      }
      currentP := currentL[0];
      currentL := currentL[1..];
    }
  }
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
  var currentL := lb;

  while true
    decreases |currentL|
    invariant currentL == lb[|lb| - |currentL| .. ]
    invariant forall i :: 0 <= i < |lb| - |currentL| ==> (i < |lb| - 1 ==> lb[i] <= lb[i+1])
  {
    if |currentL| <= 1 {
      bout := true;
      break;
    } else {
      if currentL[0] > currentL[1] {
        bout := false;
        break;
      }
      currentL := currentL[1..];
    }
  }

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
    var result: bool;
    var currentP := x;
    var currentL := xs;

    while true
      decreases |currentL|
      invariant currentL == xs[|xs| - |currentL| .. ]
      invariant currentP == if |xs| == |currentL| then x else xs[|xs| - |currentL| - 1]
      invariant |xs| > |currentL| ==> x <= xs[0]
      invariant forall i :: 0 <= i < |xs| - |currentL| - 1 ==> xs[i] <= xs[i+1]
    {
      if |currentL| == 0 {
        result := true;
        break;
      } else {
        if currentP > currentL[0] {
          result := false;
          break;
        }
        currentP := currentL[0];
        currentL := currentL[1..];
      }
    }

    rout := result;
  }

  // Computing isSortedBI
  var currentL := lb;

  while true
    decreases |currentL|
    invariant currentL == lb[|lb| - |currentL| .. ]
    invariant forall i :: 0 <= i < |lb| - |currentL| ==> (i < |lb| - 1 ==> lb[i] <= lb[i+1])
  {
    if |currentL| <= 1 {
      bout := true;
      break;
    } else {
      if currentL[0] > currentL[1] {
        bout := false;
        break;
      }
      currentL := currentL[1..];
    }
  }

  // Returning the results
  return rout, bout;
}