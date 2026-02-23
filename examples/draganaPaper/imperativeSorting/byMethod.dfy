
function isSortedB(l: seq<int>): bool
  decreases |l|
{
  if |l| == 0 then true
  else if |l| == 1 then isSortedB([])
  else l[0] <= l[1] && isSortedB(l[1..])
} by method {
  var index := 0;

  while index < |l| - 1
    invariant index <= |l|
    invariant isSortedB(l[index..]) == isSortedB(l)
  {
    if l[index] > l[index + 1] {
        return false;
    }
    index := index + 1;
  }

  return true;
}