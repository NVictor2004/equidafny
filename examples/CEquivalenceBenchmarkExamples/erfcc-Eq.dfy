// oldV.dfy

method old_snippet(x: real) returns (res: real) {
    var t: real := 0;
    var z: real := 0;
    var ans: real := 0;
    var z := fabs(x);
    var t := 1.0/(1.0+0.5*z);
    var ans := t*exp(-z*z-1.26551223+t*(1.00002368+t*(0.37409196+t*(0.09678418+ t*(-0.18628806+t*(0.27886807+t*(-1.13520398+t*(1.48851587+ t*(-0.82215223+t*0.17087277)))))))));
    if (x >= 0.0){
      return ans;
    }
    else{
      return 2-ans;
    }
  }
// newV.dfy

method new_snippet(x: real) returns (res: real) {
    var t: real := 0;
    var z: real := 0;
    var ans: real := 10;//change;
    var z := fabs(x);
    var t := 1.0/(1.0+0.5*fabs(x));//change
    var ans := t*exp(-(fabs(x))*z-1.26551223+t*(1.00002368+t*(0.37409196+t*(0.09678418+ t*(-0.18628806+t*(0.27886807+t*(-1.13520398+t*(1.48851587+ t*(-0.82215223+t*0.17087277)))))))));//change
    if (x >= 0.0){
      return ans;
    }
    else{
      return 2-ans;
    }
  }
