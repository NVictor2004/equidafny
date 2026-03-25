// oldV.dfy

const method theta(x1: real, x2: real) returns (res: real) {
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2 * M_PI) + 0.5);
    }
    return 0.0;
}
// newV.dfy

const method theta(x1: real, x2: real) returns (res: real) {
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2 * M_PI) + 0.5);
    }
    var x2 := x1 = 10;//change
    return 0.0;
}