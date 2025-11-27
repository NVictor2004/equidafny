
// Example 1: Check whether a list is sorted

// Defining isSortedR

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
        var x := currentL[0];
        if currentP > x {
            return false;
        }
        currentP := x;
        currentL := currentL[1..];
    }
  }
}

method isSortedRI(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
  if |l| == 0 {
    return true;
  } else {
    var x := l[0];
    var xs := l[1..];
    var result := loopI(x, xs);
    return result;
  }
}

// Defining isSortedB

method isSortedBI(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
  var currentL := l;

  while true
    decreases |currentL|
    invariant currentL == l[|l| - |currentL| .. ]
    invariant forall i :: 0 <= i < |l| - |currentL| ==> (i < |l| - 1 ==> l[i] <= l[i+1])
  {
    if |currentL| == 0 {
        return true;
    } else if |currentL| == 1 {
        currentL := [];
    } else {
        var x := currentL[0];
        var y := currentL[1];
        if x > y {
            return false;
        }
        currentL := currentL[1..];
    }
  }
}

// Defining isSortedC

method chkI(l: seq<int>, p: int, a: bool) returns (res: bool)
  ensures a ==> (res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1]) && (|l| > 0 ==> p <= l[0]))
  ensures !a ==> (res == false)
{
  var currentL := l;
  var currentP := p;

  while true
    decreases |currentL|
    invariant currentL == l[|l| - |currentL| .. ]
    invariant currentP == if |l| == |currentL| then p else l[|l| - |currentL| - 1]
    invariant |l| > |currentL| ==> p <= l[0]
    invariant a ==> (forall i :: 0 <= i < |l| - |currentL| - 1 ==> l[i] <= l[i+1])
  {
    if |currentL| == 0 {
      return a;
    } else {
      var x := currentL[0];
      var xs := currentL[1..];
      if x < currentP {
          return false;
      }
      currentL := xs;
      currentP := x;
    }
  }
}

method isSortedCI(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
    if |l| == 0 {
        return true;
    } else {
        var x := l[0];
        var result := chkI(l, x, true);
        return result;
    }
}

// Defining isSortedA

function leq(cur: int, next: int): bool
{
  cur < next
}

method iterI(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
  var currentL := l;

  while true
    decreases |currentL|
    invariant currentL == l[|l| - |currentL| .. ]
    invariant forall i :: 0 <= i < |l| - |currentL| ==> (i < |l| - 1 ==> l[i] <= l[i+1])
  {
    if |currentL| == 0 {
        return true;
    } else if |currentL| == 1 {
        return true;
    } else {
        var x := currentL[0];
        var y := currentL[1];
        if !leq(x, y) {
            return false;
        }
        currentL := currentL[1..];
    }
  }
}

method isSortedAI(l: seq<int>) returns (res: bool)
  ensures res <==> (forall i :: 0 <= i < |l| - 1 ==> l[i] <= l[i+1])
{
  if |l| == 0 {
    return true;
  } else if |l| == 1 {
    return true;
  } else {
    var x := l[0];
    var y := l[1];
    var rest := iterI(l[1..]);
    return x <= y && rest;
  }
}