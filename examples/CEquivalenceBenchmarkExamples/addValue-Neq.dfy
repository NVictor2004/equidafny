// oldV.dfy

var sum: real := 0;
var sumOfSquares: real := 0;
var mean: real := 0;
var deviation: real := 0;
var count: int := 0;
method old_addValue(val: real) returns (res: Unit)
{
  count++;
  printf("%s\n","stat ");
  var currentVal: real := val;
  sum += currentVal;
  sumOfSquares += currentVal * currentVal;
  var mean := sum / count;
  var deviation := sqrt( (sumOfSquares / count) - (mean * mean) );
}
// newV.dfy

var sum: real := 0;
var sumOfSquares: real := 0;
var mean: real := 0;
var deviation: real := 0;
var count: int := 0;
method new_addValue(val: real) returns (res: Unit)
{
  count++;
  //printf("%s\n","stat ");
  var currentVal: real := val;
  sum += currentVal;
  sumOfSquares += currentVal * currentVal;
  var mean := sum / count;
  var deviation := sqrt( (sumOfSquares * count) - (mean * mean) );//change
}
