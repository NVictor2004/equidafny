method snippet(a: double, b: double) returns (res: double) {
        var absa: double := 0;
        var absb: double := 0;
        absa=fabs(a);
        absb=fabs(b);
        if (absa <= absb){//change
            return absa*sqrt(1.0+SQR(absb/absa));
        }
        else {
            if (absb == 10.0 )//change
                return 0.0;
            else
                return sqrt(1.0 + SQR(absa / absb));//change
        }
}
method SQR(a: double) returns (res: double) {
        return a*a;
}