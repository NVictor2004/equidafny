function pow(x: real, y: real): real
function tan(x: real): real
function cos(x: real): real
function sin(x: real): real
function fabs(x: real): real
function sqrt(x: real): real

// oldV.dfy

method old_conflict(psi1: real, vA: real, vC: real, xC0: real, yC0: real, psiC: real, bank_ang: real, degToRad: real, g: real ) returns (res: real) { //degToRad and g are global vars
    var dmin: real := 999.0;
    var dmst: real := 2.0;
    var psiA: real := psi1 * degToRad;
    var signA: real := 1.0;
    var signC: real := 1.0;
    if (psiA < 0.0) {
      var signA := -1.0;
    }
    var rA: real := pow(vA, 2.0) / tan(bank_ang*degToRad) / g;
    var rC: real := pow(vC, 2.0) / tan(bank_ang*degToRad) / g;
    var t1: real := fabs(psiA) * rA / vA;
    var dpsiC: real := signC * t1 * vC/rC;
    var xA: real := signA*rA*(1.0-cos(psiA)); 
    var yA: real := rA*signA*sin(psiA);
    var xC: real := xC0 + signC*rC* (cos(psiC)-cos(psiC+dpsiC));
    var yC: real := yC0 - signC*rC*(sin(psiC)-sin(psiC+dpsiC));
    var xd1: real := xC - xA;
    var yd1: real := yC - yA;
    var d: real := sqrt(pow(xd1, 2.0) + pow(yd1, 2.0));
    var minsep: real := 0.0;
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
method old_snippet(x0: real, y0: real, gspeed: real, x1: real, y1: real, x2: real, y2: real, dt: real) returns (res: real) {
    var M_PI: real := 3.14159265359;
    var twoPi: real := M_PI * 2.0;
    var deg: real := M_PI / 180.0;
    var gacc: real := 32.0;
    var dx: real := x0 - x1;
    var dy: real := y0 - y1;
    if (dx == 0.0 && dy == 0.0) {
        return 0.0;
    }
    var instHdg: real := 90.0 * deg - tan(dy/dx);
    if (instHdg < 0.0) {
        instHdg := instHdg + twoPi;
    }
    if (instHdg > 2.0 * M_PI) {
        instHdg := instHdg - twoPi;
    }
    dx := x1 - x2;
    dy := y1 - y2;
    if (dx == 0.0 && dy == 0.0) { 
        return 0.0;
    }
    var instHdg0: real := 90.0 * deg - tan(dy/dx);
    if (instHdg0 < 0.0) {
        instHdg0 := instHdg0 + 360.0 * deg;
    }
    if (instHdg0 > 2.0 * M_PI) {
        instHdg0 := instHdg0 - 360.0 * deg;
    }
    var hdg_diff: real := old_normAngle(instHdg - instHdg0);
    var phi: real := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
method old_normAngle(angle: real) returns (res: real) {
    var M_PI: real := 3.14159265359;
		var twoPi: real := M_PI * 2.0; 
		if (angle < -M_PI) {
			return angle + twoPi;
		}
		if (angle > M_PI) {
			return angle - twoPi;
		}
		return angle;
	}
// newV.dfy

method new_conflict(psi1: real, vA: real, vC: real, xC0: real, yC0: real, psiC: real, bank_ang: real, degToRad: real, g: real ) returns (res: real) { //degToRad and g are global vars
    var dmin: real := 999.0;
    var dmst: real := 2.0;
    var psiA: real := psi1 * degToRad;
    var signA: real := 1.0;
    var signC: real := 1.0;
    if (psiA < 0.0) {
      var signA := -1.0;
    }
    var rA: real := pow(vA, 2.0) / tan(bank_ang*degToRad) / g;
    var rC: real := pow(vC, 2.0) / tan(bank_ang*degToRad) / g;
    var t1: real := fabs(psiA) * rA / vA;
    var dpsiC: real := t1 * vC/rC;//change
    var xA: real := signA*rA*(1.0-cos(psiA)); 
    var yA: real := rA*signA*sin(psiA);
    var xC: real := xC0 + signC*rC* (cos(psiC)-cos(psiC+dpsiC));
    var yC: real := yC0 - signC*rC*(sin(psiC)-sin(psiC+dpsiC));
    var xd1: real := xC - xA;
    var yd1: real := yC - yA;
    var d: real := sqrt(pow(xd1, 2.0) + pow(yd1, 2.0));
    var minsep: real := 0.0;
    minsep := minsep + 10.0;//change
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
method new_snippet(x0: real, y0: real, gspeed: real, x1: real, y1: real, x2: real, y2: real, dt: real) returns (res: real) {
    var M_PI: real := 3.14159265359;
    var twoPi: real := M_PI * 2.0;
    var deg: real := M_PI / 180.0;
    var gacc: real := 32.0;
    var dx: real := x0 - x1;
    var dy: real := y0 - y1;
    if (dx == 0.0 && dy == 0.0) {
        return dx;//change
    }
    var instHdg: real := 90.0 * deg - tan(dy/dx);
    if (instHdg < 0.0) {
        instHdg := instHdg + twoPi;
    }
    if (instHdg > 2.0 * M_PI) {
        instHdg := instHdg + twoPi;
    }
    dx := x1 - x2;
    dy := y1 - y2;
    if (dx == 0.0 && dy == 0.0) {
        return dy;//change
    }
    var instHdg0: real := 90.0 * deg - tan(dy/dx);
    if (instHdg0 < 0.0) {
        instHdg0 := instHdg0 + 360.0 * deg;
    }
    if (instHdg0 > twoPi) {//change
        instHdg0 := instHdg0 - 360.0 * deg;
    }
    var hdg_diff: real := new_normAngle(instHdg - instHdg0);
    var phi: real := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
method new_normAngle(angle: real) returns (res: real) {
    var M_PI: real := 3.14159265359;
		var temp: real := M_PI * 2.0; //change
		if (angle < -M_PI) {
			return angle + temp; //change
		}
		if (angle > M_PI) {
			return angle - temp; //change
		}
		return angle;
	}
