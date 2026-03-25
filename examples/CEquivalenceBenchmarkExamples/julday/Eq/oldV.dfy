method snippet(mmj: double,  idj: double,  iyyyj: double) returns (res: double) {
        var IGREG: double := 15.0+31.0*(10.0+12.0*1582.0);
        var ja: double := 1.0;
        var jul: double := 0.0;
        var jy: double := iyyyj;
        var jm: double := 0.0;
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
            jul += 2.0-ja+(0.25*ja);
        }
        return jul;
}