// oldV.dfy

method old_snippet(x: real) returns (res: real) {
        var ax: real := 0;
        var z: real := 0;
        var xx: real := 0;
        var y: real := 0;
        var ans: real := 0;
        var ans1: real := 0;
        var ans2: real := 0;
        var ax := fabs(x);
        if (ax < 8.0) {
            var y := x*x;
            var ans1 := 57568490574.0+y*(-13362590354.0+y*(651619640.7 +y*(-11214424.18+y*(77392.33017+y*(-184.9052456)))));
            var ans2 := 57568490411.0+y*(1029532985.0+y*(9494680.718 +y*(59272.64853+y*(267.8532712+y*1.0))));
            var ans := ans1/ans2;
        }
        else {
            var z := 8.0/ax;
            var y := z*z;
            var xx := ax-0.785398164;
            var ans1 := 1.0+y*(-0.1098628627e-2+y*(0.2734510407e-4 +y*(-0.2073370639e-5+y*0.2093887211e-6)));
            var ans2 := -0.1562499995e-1+y*(0.1430488765e-3 +y*(-0.6911147651e-5+y*(0.7621095161e-6 -y*0.934945152e-7)));
            var ans := ans1-z*sin(xx)*ans2;
        }
        return ans;
}
// newV.dfy

method new_snippet(x: real) returns (res: real) {
        var ax: real := 0;
        var z: real := 0;
        real xx ;//change
        var y: real := 0;
        var ans: real := 0;
        var ans1: real := 0;
        var ans2: real := 0;
        var ax := fabs(x);
        if (-ax > -8.0) {//change
            var y := x*x;
            var ans1 := 57568490574.0+y*(-13362590354.0+y*(651619640.7 +y*(-11214424.18+y*(77392.33017+y*(-184.9052456)))));
            var ans2 := 57568490411.0+y*(1029532985.0+y*(9494680.718 +y*(59272.64853+y*(267.8532712+y*1.0))));
            var ans := ans1/ans2;
        }
        else {
            var z := 8.0/ax;
            var y := z*z;
            var xx := ax-0.785398164;
            var ans1 := 1.0+y*(-0.1098628627e-2+y*(0.2734510407e-4 +y*(-0.2073370639e-5+y*0.2093887211e-6)));
            var ans2 := -0.1562499995e-1+y*(0.1430488765e-3 +y*(-0.6911147651e-5+y*(0.7621095161e-6 -y*0.934945152e-7)));
            var ans := ans1-z*sin(xx)*ans2;
        }
        return ans;
}