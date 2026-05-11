function tan(x: real): real
function atan(x: real): real

// oldV.dfy

method old_theta(x1: real, x2: real) returns (res: real) {
    var M_PI: real := 3.14159265359;
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2.0 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2.0 * M_PI) + 0.5);
    }
    return 0.0;
}
// newV.dfy

method new_theta(x1: real, x2: real) returns (res: real) {
    var M_PI: real := 3.14159265359;
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2.0 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2.0 * M_PI) - 0.5);//change
    }
    return 0.0;
}
