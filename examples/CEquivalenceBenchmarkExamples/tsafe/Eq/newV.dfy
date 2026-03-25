function conflict(psi1: double, vA: double, vC: double, xC0: double, yC0: double, psiC: double, bank_ang: double, degToRad: double, g: double ): double { //degToRad and g are global vars
    var dmin: double := 999;
    var dmst: double := 2;
    var psiA: double := psi1 * degToRad;
    var signA: double := 1;
    var signC: double := 1;
    if (psiA < 0) {
      signA = -1;
    }
    var rA: double := pow(vA, 2.0) / tan(bank_ang*degToRad) / g;
    var rC: double := pow(vC, 2.0) / tan(bank_ang*degToRad) / g;
    var t1: double := fabs(psiA) * rA / vA;
    var dpsiC: double := t1 * vC/rC;//change
    var xA: double := signA*rA*(1-cos(psiA)); 
    var yA: double := rA*signA*sin(psiA);
    var xC: double := xC0 + signC*rC* (cos(psiC)-cos(psiC+dpsiC));
    var yC: double := yC0 - signC*rC*(sin(psiC)-sin(psiC+dpsiC));
    var xd1: double := xC - xA;
    var yd1: double := yC - yA;
    var d: double := sqrt(pow(xd1, 2.0) + pow(yd1, 2.0));
    var minsep: double := 0;
    minsep +=10;//change
    if (d < dmin) {
      dmin = d;
    }
    if (dmin < dmst) {
      minsep = dmin;
    }
    else {
      minsep = dmst;
    }
    return minsep;
  }
function snippet(x0: double, y0: double, gspeed: double, x1: double, y1: double, x2: double, y2: double, dt: double): double {
    var twoPi: double := M_PI * 2;
    var deg: double := M_PI / 180;
    var gacc: double := 32.0;
    var dx: double := x0 - x1;
    var dy: double := y0 - y1;
    if (dx == 0 && dy == 0)
        return dx;//change
    var instHdg: double := 90 * deg - tan(dy/dx);
    if (instHdg < 0.)
        instHdg += twoPi;
    if (instHdg > 2 * M_PI)
        instHdg += twoPi;
    dx = x1 - x2;
    dy = y1 - y2;
    if (dx == 0 && dy == 0)
        return dy;//change
    var instHdg0: double := 90 * deg - tan(dy/dx);
    if (instHdg0 < 0.)
        instHdg0 += 360 * deg;
    if (instHdg0 > twoPi)//change
        instHdg0 -= 360 * deg;
    var hdg_diff: double := normAngle(instHdg - instHdg0);
    var phi: double := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
function normAngle(angle: double): double {
		var temp: double := M_PI * 2; //change
		if (angle < -M_PI) {
			return angle + temp; //change
		}
		if (angle > M_PI) {
			return angle - temp; //change
		}
		return angle;
	}