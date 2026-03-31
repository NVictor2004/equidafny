// oldV.dfy

method old_snippet(x: real) returns (res: real) {
        var z: real := 0;
        var xx: real := 0;
        var y: real := 0;
        var ans: real := 0;
        var ans1: real := 0;
        var ans2: real := 0;
        if (x < 8.0) {
            if(x!=0){
            var y := x*x;
            var ans1 := x*(-0.4900604943e13+y*(0.1275274390e13 +y*(-0.5153438139e11+y*(0.7349264551e9 +y*(-0.4237922726e7+y*0.8511937935e4)))));
            var ans2 := 0.2499580570e14+y*(0.4244419664e12 +y*(0.3733650367e10+y*(0.2245904002e8 +y*(0.1020426050e6+y*(0.3549632885e3+y)))));
            var ans := (ans1/ans2)+0.636619772*(old_bessj1(x)*old_log(x)-(1.0/x));
            }
        }
        else {
            var z := 8.0/x;
            var y := z*z;
            var xx := x-2.356194491;
            var ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4 +y*(0.2457520174e-5+y*(-0.240337019e-6))));
            var ans2 := 0.04687499995+y*(-0.2002690873e-3 +y*(0.8449199096e-5+y*(-0.88228987e-6 +y*0.105787412e-6)));
            var ans := sqrt(0.636619772/x)*(sin(xx)*ans1+z*cos(xx)*ans2);
        }
        return ans;
}
method old_bessj1(x: real) returns (res: real){
        real  ax,z,xx,y,ans,ans1,ans2;

        if ((ax=fabs(x)) < 8.0) {
            var y := x*x;
            ans1=x*(72362614232.0+y*(-7895059235.0+y*(242396853.1
                    +y*(-2972611.439+y*(15704.48260+y*(-30.16036606))))));
            ans2=144725228442.0+y*(2300535178.0+y*(18583304.74
                    +y*(99447.43394+y*(376.9991397+y*1.0))));
            var ans := ans1/ans2;
        } else {
            var z := 8.0/ax;
            var y := z*z;
            var xx := ax-2.356194491;
            ans1=1.0+y*(0.183105e-2+y*(-0.3516396496e-4
                    +y*(0.2457520174e-5+y*(-0.240337019e-6))));
            ans2=0.04687499995+y*(-0.2002690873e-3
                    +y*(0.8449199096e-5+y*(-0.88228987e-6
                    +y*0.105787412e-6)));
            var ans := sqrt(0.636619772/ax)*(cos(xx)*ans1-z*sin(xx)*ans2);
            if (x < 0.0) var ans := -ans;
        }
        return ans;
}
// newV.dfy

method new_snippet(x: real) returns (res: real) {
        var z: real := 0;
        var xx: real := 0;
        real y ;//change
        var ans: real := 0 ;
        var ans1: real := 0;
        var ans2: real := 0;
        if (x < 8.0) {
            if(x!=0){
            var y := x*x;
            var ans1 := x*(-0.4900604943e13+y*(0.1275274390e13 +y*(-0.5153438139e11+y*(0.7349264551e9 +y*(-0.4237922726e7+y*0.8511937935e4)))));
            var ans2 := 0.2499580570e14+y*(0.4244419664e12 +y*(0.3733650367e10+y*(0.2245904002e8 +y*(0.1020426050e6+y*(0.3549632885e3+y)))));
            var ans := (ans1/ans2)+0.636619772*(new_bessj1(x)*new_log(x)-(1.0/x));
            }
        }
        else {
            var z := 8.0/x;
            var y := z*z;
            var xx := x-2.356194491;
            var ans1 := 1.0+y*(0.183105e-2+y*(-0.3516396496e-4 +y*(0.2457520174e-5+y*(-0.240337019e-6))));
            var ans2 := 0.04687499995+y*(-0.2002690873e-3 +y*(0.8449199096e-5+y*(-0.88228987e-6 +y*0.105787412e-6)));
            var ans := (sqrt(0.636619772/x)*(sin(xx)*ans1))+(sqrt(0.636619772/x)*z*cos(xx)*ans2);//change
        }
        return ans;
}
method new_bessj1(x: real) returns (res: real){
        real  ax,z,xx,y,ans,ans1,ans2;

        if ((ax=fabs(x)) < 8.0) {
            var y := x*x;
            ans1=x*(72362614232.0+y*(-7895059235.0+y*(242396853.1
                    +y*(-2972611.439+y*(15704.48260+y*(-30.16036606))))));
            ans2=144725228442.0+y*(2300535178.0+y*(18583304.74
                    +y*(99447.43394+y*(376.9991397+y*1.0))));
            var ans := ans1/ans2;
        } else {
            var z := 8.0/ax;
            var y := z*z;
            var xx := ax-2.356194491;
            ans1=1.0+y*(0.183105e-2+y*(-0.3516396496e-4
                    +y*(0.2457520174e-5+y*(-0.240337019e-6))));
            ans2=0.04687499995+y*(-0.2002690873e-3
                    +y*(0.8449199096e-5+y*(-0.88228987e-6
                    +y*0.105787412e-6)));
            var ans := sqrt(0.636619772/ax)*(cos(xx)*ans1-z*sin(xx)*ans2);
            if (x < 0.0) var ans := -ans;
        }
        return ans;
}
