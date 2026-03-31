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
        if ((10.0 * (x2 - x1 * x1)) == 10.0 && (5.0 - x1) == 0.0//change
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
      return (new_atan(x2 / x1) / (2 * M_PI) - 0.5);//change
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
