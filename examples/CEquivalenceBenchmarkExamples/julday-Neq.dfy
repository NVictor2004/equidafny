// oldV.dfy

method old_snippet(mmj: real,  idj: real,  iyyyj: real) returns (res: real) {
        var IGREG: real := 15.0+31.0*(10.0+12.0*1582.0);
        var ja: real := 1.0;
        var jul: real := 0.0;
        var jy: real := iyyyj;
        var jm: real := 0.0;
        if (jy == 0.0) 
           return 0.0;
        if (jy < 0.0)
            ++jy;
        if (mmj > 2.0) {
            var jm := mmj+1.0;
        }
        else {
            --jy;
            var jm := mmj+13.0;
        }
        var jul := fabs(365.0*jy)+sqrt(30.0*jm)+idj+1720995.0;
        if (idj+31.0*(mmj+12.0*iyyyj) <= IGREG ) {
            var ja := (0.01*jy);
            jul := jul + 2.0-ja+(0.25*ja);
        }
        return jul;
}
// newV.dfy

method new_snippet(mmj: real,  idj: real,  iyyyj: real) returns (res: real) {
        var IGREG: real := 15.0+31.0*(10.0+12.0*1582.0);
        var ja: real := 1.0;
        var jul: real := 0.0;
        var jy: real := iyyyj;
        var jm: real := 0.0;
        if (jy == 0.0) 
           return 0.0+ja;//change
        if (jy < 0.0)
            ++jy;
        if (mmj > 2.0) {
            var jm := mmj+1.0;
        }
        else {
            --jy;
            var jm := mmj+13.0;
        }
        var jul := fabs(365.0*jy)+sqrt(30.0*jm)+idj+1720995.0;
        if (idj+31.0*(mmj+12.0*iyyyj) <= IGREG ) {
            var ja := (0.01*jy);
            jul := jul + 2.0-ja+(0.25*ja);
        }
        return jul+fabs(iyyyj);//change
}
