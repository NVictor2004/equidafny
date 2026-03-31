// oldV.dfy

method old_snippet(x: real) returns (res: real) {
        var ax: real := 0;
        var ans: real := 0;
        var y: real := 0;
        var ax := fabs(x);
        if (ax < 3.75) {
            var y := x/3.75;
            y*=y;
            var ans := 1.0+y+(3.5156229+y*(3.0899424+y*(1.2067492+y*(0.2659732+y*(0.360768e-1+y*0.45813e-2)))));
        }
        else {
            var y := 3.75/ax;
            var ans := fabs(x)*(0.39894228+y*(0.1328592e-1 +y*(0.225319e-2+y*(-0.157565e-2+y*(0.916281e-2 +y*(-0.2057706e-1+y*(0.2635537e-1+y*(-0.1647633e-1 +y*0.392377e-2))))))));
        }
        return ans;
}
// newV.dfy

method new_snippet(x: real) returns (res: real) {
        var axRenamed: real := 0;//change
        var ans: real := 0;
        var y: real := 0;
        var axRenamed := fabs(x);//change
        if (axRenamed < 3.75) {//change
            var y := x/3.75;
            y*=y;
            var ans := 1.0+y+(3.5156229+y*(3.0899424+y*(1.2067492+y*(0.2659732+y*(0.360768e-1+y*0.45813e-2)))));
        }
        else {
            var y := 3.75/axRenamed;//change
            var ans := fabs(x)*(0.39894228+y*(0.1328592e-1 +y*(0.225319e-2+y*(-0.157565e-2+y*(0.916281e-2 +y*(-0.2057706e-1+y*(0.2635537e-1+y*(-0.1647633e-1 +y*0.392377e-2))))))));
        }
        return ans;
}
