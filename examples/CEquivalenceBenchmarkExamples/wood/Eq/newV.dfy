function wood(x1: double, x2: double, x3: double, x4: double): Unit {
      var condition1: bool := (10.0 * (x2 - x1 * x1)) == 0.0 && (5.0 - x1) == 0.0;//change
      var condition2: bool := (sqrt(64) * (x4 - x3 * x3)) == 0.0 && (2.0 - x3) == 0.0;//change
        if (condition1 && condition2){//change
          printf("%s\n","Solved Wood constraint");
        }
    }