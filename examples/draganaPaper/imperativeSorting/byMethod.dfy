
function isSortedB(l: seq<int>): bool
  decreases |l|
{
  if |l| == 0 then true
  else if |l| == 1 then isSortedB([])
  else l[0] <= l[1] && isSortedB(l[1..])
} by method {
  var currentL := l;

  while true
    decreases |currentL|
    invariant isSortedB(currentL) == isSortedB(l)
  {
    if |currentL| <= 1 {
        return true;
    } else {
        if currentL[0] > currentL[1] {
            return false;
        }
        currentL := currentL[1..];
    }
  }
}