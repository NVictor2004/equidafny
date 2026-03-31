function sqrt(x: real): real

// oldV.dfy

method old_wood(x1: real, x2: real, x3: real, x4: real) {
        if ((10.0 * (x2 - x1 * x1)) == 0.0 && (5.0 - x1) == 0.0
            && (sqrt(64.0) * (x4 - x3 * x3)) == 0.0
            && (2.0 - x3) == 0.0) {
          print("%s\n","Solved Wood constraint");
        }
    }
// newV.dfy

method new_wood(x1: real, x2: real, x3: real, x4: real) {
      var condition1: bool := (10.0 * (x2 - x1 * x1)) == 0.0 && (5.0 - x1) == 0.0;//change
      var condition2: bool := (sqrt(64.0) * (x4 - x3 * x3)) == 0.0 && (2.0 - x3) == 0.0;//change
        if (condition1 && condition2){//change
          print("%s\n","Solved Wood constraint");
        }
    }
