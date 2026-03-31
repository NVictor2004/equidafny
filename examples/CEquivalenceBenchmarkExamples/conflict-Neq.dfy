function pow(x: real, y: real): real
function tan(x: real): real
function cos(x: real): real
function sin(x: real): real
function fabs(x: real): real
function sqrt(x: real): real

// oldV.dfy

method old_snippet(psi1: real, vA: real, vC: real, xC0: real, yC0: real, psiC: real, bank_ang: real, degToRad: real, g: real ) returns (res: real) { //degToRad and g are global vars
    var dmin: real := 999;
    var dmst: real := 2;
    var psiA: real := psi1 * degToRad;
    var signA: real := 1;
    var signC: real := 1;
    if (psiA < 0) {
      var signA := -1;
    }
    var rA: real := pow(vA, 2.0) / tan(bank_ang*degToRad) / g;
    var rC: real := pow(vC, 2.0) / tan(bank_ang*degToRad) / g;
    var t1: real := fabs(psiA) * rA / vA;
    var dpsiC: real := signC * t1 * vC/rC;
    var xA: real := signA*rA*(1-cos(psiA)); 
    var yA: real := rA*signA*sin(psiA);
    var xC: real := xC0 + signC*rC* (cos(psiC)-cos(psiC+dpsiC));
    var yC: real := yC0 - signC*rC*(sin(psiC)-sin(psiC+dpsiC));
    var xd1: real := xC - xA;
    var yd1: real := yC - yA;
    var d: real := sqrt(pow(xd1, 2.0) + pow(yd1, 2.0));
    var minsep: real := 0;
    if (d < dmin) {
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
// newV.dfy

method new_snippet(psi1: real, vA: real, vC: real, xC0: real, yC0: real, psiC: real, bank_ang: real, degToRad: real, g: real ) returns (res: real) { //degToRad and g are global vars
    var dmin: real := 999;
    var dmst: real := 2;
    var psiA: real := psi1 * degToRad;
    var signA: real := 1;
    var signC: real := 1;
    if (psiA < 0) {
      var signA := -1;
    }
    var rA: real := pow(vA, 2.0) / tan(bank_ang*degToRad) / g;
    var rC: real := pow(vC, 2.0) / tan(bank_ang*degToRad) / g;
    var t1: real := fabs(psiA) * rA / vA;
    var dpsiC: real := signC * t1 * vC/rC;
    var xA: real := signA*rA*(1-cos(psiA)); 
    var yA: real := rA*signA*sin(psiA);
    var xC: real := xC0 + signC*rC* (cos(psiC)-cos(psiC+dpsiC));
    var yC: real := yC0 - signC*rC*(sin(psiC)-sin(psiC+dpsiC));
    var xd1: real := xC - xA;
    var yd1: real := yC - yA;
    var d: real := sqrt(pow(xd1, 2.0) + pow(yd1, 2.0));
    var minsep: real := 0;
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
