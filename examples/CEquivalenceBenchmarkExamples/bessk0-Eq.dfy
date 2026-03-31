// oldV.dfy

method old_snippet(x: real) returns (res: real) {
        var y: real := 0;
        var ans: real := 0;
        if (x <= 2.0) {
            var y := x*x/4.0;
            var ans := (-old_log(x/2.0)*old_bessi0(x))+(-0.57721566+y*(0.42278420 +y*(0.23069756+y*(0.3488590e-1+y*(0.262698e-2 +y*(0.10750e-3+y*0.74e-5))))));
        }
        else {
            var y := 2.0/x;
            var ans := (exp(-x)/sqrt(x))*(1.25331414+y*(-0.7832358e-1 +y*(0.2189568e-1+y*(-0.1062446e-1+y*(0.587872e-2 +y*(-0.251540e-2+y*0.53208e-3))))))+y;
        }
        return ans;
}
method old_bessi0(x: real) returns (res: real) {
        real ax,ans,y;

        if ((ax=fabs(x)) < 3.75) {
            var y := x/3.75;
            y := y * y;
            ans=1.0+y*(3.5156229+y*(3.0899424+y*(1.2067492
                    +y*(0.2659732+y*(0.360768e-1+y*0.45813e-2)))));
        } else {
            var y := 3.75/ax;
            ans=(exp(ax)/sqrt(ax))*(0.39894228+y*(0.1328592e-1
                    +y*(0.225319e-2+y*(-0.157565e-2+y*(0.916281e-2
                    +y*(-0.2057706e-1+y*(0.2635537e-1+y*(-0.1647633e-1
                    +y*0.392377e-2))))))));
        }
        return ans;
}
// newV.dfy

method new_snippet(x: real) returns (res: real) {
        var y: real := 0;
        var ans: real := 0;
        var two: real := 2.0;//change
        if (x <= two) {//change
            var y := x*x/4.0;
            var ans := (-new_log(x/2.0)*new_bessi0(x))+(-0.57721566+y*(0.42278420 +y*(0.23069756+y*(0.3488590e-1+y*(0.262698e-2 +y*(0.10750e-3+y*0.74e-5))))));
        }
        else {
            var y := two/x;//change
            var ans := (exp(-x)/sqrt(x))*(1.25331414+y*(-0.7832358e-1 +y*(0.2189568e-1+y*(-0.1062446e-1+y*(0.587872e-2 +y*(-0.251540e-2+y*0.53208e-3))))))+y;
        }
        return ans;
}
method new_bessi0(x: real) returns (res: real) {
        real ax,ans,y;

        if ((ax=fabs(x)) < 3.75) {
            var y := x/3.75;
            y := y * y;
            ans=1.0+y*(3.5156229+y*(3.0899424+y*(1.2067492
                    +y*(0.2659732+y*(0.360768e-1+y*0.45813e-2)))));
        } else {
            var y := 3.75/ax;
            ans=(exp(ax)/sqrt(ax))*(0.39894228+y*(0.1328592e-1
                    +y*(0.225319e-2+y*(-0.157565e-2+y*(0.916281e-2
                    +y*(-0.2057706e-1+y*(0.2635537e-1+y*(-0.1647633e-1
                    +y*0.392377e-2))))))));
        }
        return ans;
}
