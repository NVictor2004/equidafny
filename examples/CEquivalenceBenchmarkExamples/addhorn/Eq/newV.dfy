method new_f(i: int, j: int) returns (res: int)
{
  var r := 0;
  if (i == 0) {
    var r := j;
  } else {
    if (i == 1) {
      var r := j + 1;
    } else {
      var r := f(i - 1, j + 1);
    }
  }
  return r;
}
