// oldV.dfy

var sum: double := 0;
var sumOfSquares: double := 0;
var mean: double := 0;
var deviation: double := 0;
var count: int := 0;
method old_addValue(val: double) returns (res: Unit)
{
  count++;
  printf("%s\n","stat ");
  var currentVal: double := val;
  sum += currentVal;
  sumOfSquares += currentVal * currentVal;
  var mean := sum / count;
  var deviation := sqrt( (sumOfSquares / count) - (mean * mean) );
}
// newV.dfy

var sum: double := 0;
var sumOfSquares: double := 0;
var mean: double := 0;
var deviation: double := 0;
var count: int := 0;
method new_addValue(val: double) returns (res: Unit)
{
  count++;
  printf("%s\n","stat ");
  //var currentVal: double := val;
  sum += val;//change
  sumOfSquares += val * val;//change
  var mean := sum / count;
  var deviation := sqrt( (sumOfSquares / count) - (mean * mean) );
}