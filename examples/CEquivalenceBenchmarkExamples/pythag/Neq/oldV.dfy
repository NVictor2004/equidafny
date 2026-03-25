function snippet(a: double, b: double): double {
        var absa: double := 0;
        var absb: double := 0;
        absa=fabs(a);
        absb=fabs(b);
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
function SQR(a: double): double {
        return a*a;
}