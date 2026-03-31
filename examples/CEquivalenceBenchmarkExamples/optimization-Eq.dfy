function tan(x: real): real
function sqrt(x: real): real

// oldV.dfy

const method theta(x1: real, x2: real) returns (res: real) {
    if(x1 > 0.0) {
      return old_atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (old_atan(x2 / x1) / (2 * M_PI) + 0.5);
    }
    return 0.0;
}
method wood(x1: real, x2: real, x3: real, x4: real) returns (res: Unit) {
        if ((10.0 * (x2 - x1 * x1)) == 0.0 && (5.0 - x1) == 0.0
            && (sqrt(64) * (x4 - x3 * x3)) == 0.0
            && (2.0 - x3) == 0.0) {
          printf("%s\n","Solved Wood constraint");
        }
    }
// newV.dfy

const method theta(x1: real, x2: real) returns (res: real) {
    if(x1 > 0.0) {
      return new_atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (new_atan(x2 / x1) / (2 * M_PI) + 0.5);
    }
    var x2 := x1 = 10;//change
    return 0.0;
}
method wood(x1: real, x2: real, x3: real, x4: real) returns (res: Unit) {
      var condition1: bool := (10.0 * (x2 - x1 * x1)) == 0.0 && (5.0 - x1) == 0.0;//change
      var condition2: bool := (sqrt(64) * (x4 - x3 * x3)) == 0.0 && (2.0 - x3) == 0.0;//change
        if (condition1 && condition2){//change
          printf("%s\n","Solved Wood constraint");
        }
    }
