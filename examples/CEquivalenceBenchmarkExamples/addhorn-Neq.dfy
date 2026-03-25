// oldV.dfy

method old_f(i: int, j: int) returns (res: int)
{
  var r := 0;
  if (i == 0) {
    var r := j;
  } else {
    var r := f(i - 1, j + 1);
  }
  return r;
}

// newV.dfy

method new_f(i: int, j: int) returns (res: int)
{
  var r := 0;
  if (i == 0) {
    var r := j;
  } else {
    if (i == 1) {
      var r := j + 1;
    } else { 
      if (i == 2) {
      var r := j;
    } else {
      var r := f(i - 1, j + 1);
    }}
  }
  return r;
}
