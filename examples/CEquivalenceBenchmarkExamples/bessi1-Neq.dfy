function exp(x: real): real
function fabs(x: real): real
function sqrt(x: real): real

// oldV.dfy

method old_snippet(x: real) returns (res: real) {
        var ax: real := 0.0;
        var ans: real := 0.0;
        var y: real := 0.0;
        ax := fabs(x);
        if (ax < 3.75) {
            var y := x/3.75;
            y := y * y;
            var ans := ax*(0.5+y*(0.87890594+y*(0.51498869+y*(0.15084934 +y*(0.2658733e-1+y*(0.301532e-2+y*0.32411e-3))))));
        } else {
            var y := 3.75/ax;
            var ans := 0.2282967e-1+y*(-0.2895312e-1+y*(0.1787654e-1 -y*0.420059e-2));
            ans := 0.39894228+y*(-0.3988024e-1+y*(-0.362018e-2 +y*(0.163801e-2+y*(-0.1031555e-1+y*ans))));
            ans := ans * (exp(ax)/sqrt(ax));
        }
        if (x < 0.0) {
            return -ans;
        } else {
            return ans;
        }
}
// newV.dfy

method new_snippet(x: real) returns (res: real) {
        var ax: real := 0.0;
        var ans: real := 0.0;
        var y: real := 0.0;
        ax := fabs(x);
        if (ax < 3.75) {
            var y := x/3.75;
            y := y / y;//change
            var ans := ax*(0.5+y*(0.87890594+y*(0.51498869+y*(0.15084934 +y*(0.2658733e-1+y*(0.301532e-2+y*0.32411e-3))))));
        } else {
            var y := 3.75/ax;
            var ans := 0.2282967e-1+y*(-0.2895312e-1+y*(0.1787654e-1 -y*0.420059e-2));
            ans := 0.39894228+y*(-0.3988024e-1+y*(-0.362018e-2 +y*(0.163801e-2+y*(-0.1031555e-1+y*ans))));
            ans := ans * (exp(ax)/sqrt(ax));
            ans := ans + y;//change
        }
        if (x <= 50.0 && x >= -50.0) {//change
            return -ans;
        } else {
            return ans;
        }
}
