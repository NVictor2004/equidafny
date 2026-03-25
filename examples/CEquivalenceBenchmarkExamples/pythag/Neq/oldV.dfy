method snippet(a: double, b: double) returns (res: double) {
        var absa: double := 0;
        var absb: double := 0;
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
method SQR(a: double) returns (res: double) {
        return a*a;
}