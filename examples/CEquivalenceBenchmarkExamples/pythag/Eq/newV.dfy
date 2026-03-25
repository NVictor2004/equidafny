method new_snippet(a: double, b: double) returns (res: double) {
        var absa: double := 0;
        var absb: double := 0;
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
method new_SQR(a: double) returns (res: double) {
        return a*a;
}