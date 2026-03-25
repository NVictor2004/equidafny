// oldV.dfy

method old_snippet(x0: double, y0: double, gspeed: double, x1: double, y1: double, x2: double, y2: double, dt: double) returns (res: double) {
    var twoPi: double := M_PI * 2;
    var deg: double := M_PI / 180;
    var gacc: double := 32.0;
    var dx: double := x0 - x1;
    var dy: double := y0 - y1;
    if (dx == 0 && dy == 0)
        return 0.0;
    var instHdg: double := 90 * deg - tan(dy/dx);
    if (instHdg < 0.)
        instHdg += twoPi;
    if (instHdg > 2 * M_PI)
        instHdg += twoPi;
    var dx := x1 - x2;
    var dy := y1 - y2;
    if (dx == 0 && dy == 0)
        return 0.0;
    var instHdg0: double := 90 * deg - tan(dy/dx);
    if (instHdg0 < 0.)
        instHdg0 += 360 * deg;
    if (instHdg0 > 2 * M_PI)
        instHdg0 -= 360 * deg;
    var hdg_diff: double := normAngle(instHdg - instHdg0);
    var phi: double := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
method old_normAngle(angle: double) returns (res: double) {
        var twoPi: double := M_PI * 2;
        if (angle < -M_PI) {
			return angle + twoPi;
		}
		if (angle > M_PI) {
			return angle - twoPi;
		}
		return angle;
    }
// newV.dfy

method new_snippet(x0: double, y0: double, gspeed: double, x1: double, y1: double, x2: double, y2: double, dt: double) returns (res: double) {
    var twoPi: double := M_PI * 2;
    var deg: double := M_PI / 180;
    var gacc: double := 32.0;
    var dx: double := x0 - x1;
    var dy: double := y0 - y1;
    if (dx == 0 )//change:
        return 1.0;//change:
    var instHdg: double := 90 * deg - tan(dy/dx);
    if (instHdg < 0.)
        instHdg += twoPi;
    if (instHdg > 4 * M_PI)//change
        instHdg += twoPi;
    var dx := x1 - x2;
    var dy := y1 - y2;
    if (dx == 0 && dy == 0)
        return 0.0;
    var instHdg0: double := 90 * deg - tan(dy/dx);
    if (instHdg0 < 0.)
        instHdg0 += 360 * deg;
    if (instHdg0 > 2 * M_PI)
        instHdg0 -= 360 * deg;
    var hdg_diff: double := normAngle(instHdg - instHdg0);
    var phi: double := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
method new_normAngle(angle: double) returns (res: double) {
        var twoPi: double := M_PI * 2;
        if (angle < -M_PI) {
			return angle + twoPi;
		}
		if (angle > M_PI) {
			return angle - twoPi;
		}
		return angle;
    }