function SQR(a: double): double;
function snippet(a: double, b: double): double {
        double absa = 0;
        double absb = 0;
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
function SQR(a: double): double {
        return a*a;
}