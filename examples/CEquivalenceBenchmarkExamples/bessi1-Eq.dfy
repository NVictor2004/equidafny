// oldV.dfy

method old_snippet(x: double) returns (res: double) {
        var ax: double := 0;
        var ans: double := 0;
        var y: double := 0;
        var ax := fabs(x);
        if (ax < 3.75) {
            var y := x/3.75;
            y*=y;
            var ans := ax*(0.5+y*(0.87890594+y*(0.51498869+y*(0.15084934 +y*(0.2658733e-1+y*(0.301532e-2+y*0.32411e-3))))));
        } else {
            var y := 3.75/ax;
            var ans := 0.2282967e-1+y*(-0.2895312e-1+y*(0.1787654e-1 -y*0.420059e-2));
            var ans := 0.39894228+y*(-0.3988024e-1+y*(-0.362018e-2 +y*(0.163801e-2+y*(-0.1031555e-1+y*ans))));
            ans *= (exp(ax)/sqrt(ax));
        }
        if (x < 0.0)
            return -ans;
        else
            return ans;
}
// newV.dfy

method new_snippet(x: double) returns (res: double) {
        var ax: double := 0;
        var ans: double := 0;
        var y: double := 0;
        var ax := fabs(x);
        if (ax < 3.75) {
            var y := x/3.75;
            y*=y;
            var ans := ax*(0.5+y*(0.87890594+y*(0.51498869+y*(0.15084934 +y*(0.2658733e-1+y*(0.301532e-2+y*0.32411e-3))))));
        } else {
            var y := 3.75/ax;
            var ansRenamed: double := 0.2282967e-1+y*(-0.2895312e-1+y*(0.1787654e-1 -y*0.420059e-2));//change
            var ans := 0.39894228+y*(-0.3988024e-1+y*(-0.362018e-2 +y*(0.163801e-2+y*(-0.1031555e-1+y*ansRenamed))));//change
            ans *= (exp(ax)/sqrt(ax));
        }
        if (x < 0.0)
            return -ans;
        else
            return ans;
}