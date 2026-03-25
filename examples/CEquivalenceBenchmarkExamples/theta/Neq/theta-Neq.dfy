// oldV.dfy

const method theta(x1: double, x2: double) returns (res: double) {
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2 * M_PI) + 0.5);
    }
    return 0.0;
}
// newV.dfy

const method theta(x1: double, x2: double) returns (res: double) {
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2 * M_PI) - 0.5);//change
    }
    return 0.0;
}