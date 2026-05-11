function sqrt(x: real): real

// oldV.dfy

method old_addValue(sum: real, sumOfSquares: real, mean: real, deviation: real, count: real, val: real) returns (
  resSum: real, resSumOfSquares: real, resMean: real, resDeviation: real, resCount: real)
{
  resCount := count + 1.0;
  print("%s\n","stat ");
  var currentVal: real := val;
  resSum := sum + currentVal;
  resSumOfSquares := sumOfSquares + (currentVal * currentVal);
  resMean := resSum / resCount;
  resDeviation := sqrt( (resSumOfSquares / resCount) - (resMean * resMean) );
}
// newV.dfy

method new_addValue(sum: real, sumOfSquares: real, mean: real, deviation: real, count: real, val: real) returns (
  resSum: real, resSumOfSquares: real, resMean: real, resDeviation: real, resCount: real)
{
  resCount := count + 1.0;
  print("%s\n","stat ");
  //var currentVal: real := val;
  resSum := sum + val;//change
  resSumOfSquares := sumOfSquares + (val * val);//change
  resMean := resSum / resCount;
  resDeviation := sqrt( (resSumOfSquares / resCount) - (resMean * resMean) );
}
