var sum: double := 0;
var sumOfSquares: double := 0;
var mean: double := 0;
var deviation: double := 0;
var count: int := 0;
method addValue(val: double) returns (res: Unit)
{
  count++;
  printf("%s\n","stat ");
  var currentVal: double := val;
  sum += currentVal;
  sumOfSquares += currentVal * currentVal;
  mean = sum / count;
  deviation = sqrt( (sumOfSquares / count) - (mean * mean) );
}