const function theta(x1: double, x2: double): double {
    if(x1 > 0.0) {
      return atan(x2 / x1) / (2 * M_PI);
    } else if (x1 < 0.0) {
      return (atan(x2 / x1) / (2 * M_PI) + 0.5);
    }
    return 0.0;
}