function cos(x: real): real
function sin(x: real): real
function fabs(x: real): real
function sqrt(x: real): real

// oldV.dfy

method old_snippet(x: real) returns (res: real) {
        var ax: real := 0.0;
        var z: real := 0.0;
        var xx: real := 0.0;
        var y: real := 0.0;
        var ans: real := 0.0;
        var ans1: real := 0.0;
        var ans2: real := 0.0;
        ax := fabs(x);
        if (ax < 8.0) {
            var y := x*x;
            var ans1 := x*(72362614232.0+y*(-7895059235.0+y*(242396853.1 +y*(-2972611.439+y*(15704.48260+y*(-30.16036606))))));
            var ans2 := 144725228442.0+y*(2300535178.0+y*(18583304.74 +y*(99447.43394+y*(376.9991397+y*1.0))));
            var ans := ans1/ans2;
        }
        else {
            var z := 8.0/ax;
            var y := z*z;
            var xx := ax-2.356194491;
            var ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4 +y*(0.2457520174e-5+y*(-0.240337019e-6))));
            var ans2 := 0.04687499995+y*(-0.2002690873e-3 +y*(0.8449199096e-5+y*(-0.88228987e-6 +y*0.105787412e-6)));
            var ans := sqrt(0.636619772/ax)*(cos(xx)*ans1-z*sin(xx)*ans2);
            if (x < 0.0) {
                var ans := -ans;
            }
        }
        return ans;
}
// newV.dfy

method new_snippet(x: real) returns (res: real) {
        var ax: real := 0.0;
        var z: real := 0.0;
        var xx: real := 0.0;
        var y: real := 0.0;
        var ans: real := 0.0;
        var ans1: real := 0.0;
        var ans2: real := 0.0;
        ax := fabs(x);
        if (ax < 8.0) {
            var y := x*x;
            var ans1 := x*(72362614232.0+y*(-7895059235.0+y*(242396853.1 +y*(-2972611.439+y*(15704.48260+y*(-30.16036606))))));
            var ans2 := 144725228442.0+y*(2300535178.0+y*(18583304.74 +y*(99447.43394+y*(376.9991397+y))));//change
            var ans := ans1/ans2;
        }
        else {
            var eight: real := 8.0; 
            var z := eight/ax;//change
            var y := (8.0/fabs(x))*(8.0/fabs(x));//change
            var xx := ax-2.356194491;
            var ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4 +y*(0.2457520174e-5+y*(-0.240337019e-6))));
            var ans2 := 0.04687499995+y*(-0.2002690873e-3 +y*(0.8449199096e-5+y*(-0.88228987e-6 +y*0.105787412e-6)));
            var ans := sqrt(0.636619772/ax)*(cos(xx)*ans1-z*sin(xx)*ans2);
            if (x < 0.0) {
                var ans := -ans;
            }
        }
        return ans;
}
