// oldV.dfy

method old_snippet(a: real, b: real) returns (res: real) {
        var absa: real := 0;
        var absb: real := 0;
        var absa := fabs(a);
        var absb := fabs(b);
        if (absa > absb){
            return absa*sqrt(1.0+SQR(absb/absa));
        }
        else {
            if (absb == 0.0 )
                return 0.0;
            else
                return absb * sqrt(1.0 + SQR(absa / absb));
        }
}
method old_SQR(a: real) returns (res: real) {
        return a*a;
}
// newV.dfy

method new_snippet(a: real, b: real) returns (res: real) {
        var absa: real := 0;
        var absb: real := 0;
        var absa := fabs(a);
        var absb := fabs(b);
        if (absa > absb){
            return absa*sqrt(1.0+SQR(absb/absa));
        }
        else {
            if (absb != 0.0 )//change
                return absb * sqrt(1.0 + SQR(absa / absb));//change
            else
                return absb;//change
        }
}
method new_SQR(a: real) returns (res: real) {
        return a*a;
}
