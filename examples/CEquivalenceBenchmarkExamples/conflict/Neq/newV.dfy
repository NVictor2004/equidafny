method snippet(psi1: double, vA: double, vC: double, xC0: double, yC0: double, psiC: double, bank_ang: double, degToRad: double, g: double ) returns (res: double) { //degToRad and g are global vars
    var dmin: double := 999;
    var dmst: double := 2;
    var psiA: double := psi1 * degToRad;
    var signA: double := 1;
    var signC: double := 1;
    if (psiA < 0) {
      var signA := -1;
    }
    var rA: double := pow(vA, 2.0) / tan(bank_ang*degToRad) / g;
    var rC: double := pow(vC, 2.0) / tan(bank_ang*degToRad) / g;
    var t1: double := fabs(psiA) * rA / vA;
    var dpsiC: double := signC * t1 * vC/rC;
    var xA: double := signA*rA*(1-cos(psiA)); 
    var yA: double := rA*signA*sin(psiA);
    var xC: double := xC0 + signC*rC* (cos(psiC)-cos(psiC+dpsiC));
    var yC: double := yC0 - signC*rC*(sin(psiC)-sin(psiC+dpsiC));
    var xd1: double := xC - xA;
    var yd1: double := yC - yA;
    var d: double := sqrt(pow(xd1, 2.0) + pow(yd1, 2.0));
    var minsep: double := 0;
   if (d < dmin && rA>rC) {//change
      var dmin := d;
    }
    if (dmin < dmst) {
      var minsep := dmin;
    }
    else {
      var minsep := dmst;
    }
    return minsep;
  }