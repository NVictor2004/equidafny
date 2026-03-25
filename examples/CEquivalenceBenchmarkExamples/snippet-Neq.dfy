// oldV.dfy

method old_snippet(x0: real, y0: real, gspeed: real, x1: real, y1: real, x2: real, y2: real, dt: double) returns (res: double) {
    var twoPi: real := M_PI * 2;
    var deg: real := M_PI / 180;
    var gacc: real := 32.0;
    var dx: real := x0 - x1;
    var dy: real := y0 - y1;
    if (dx == 0 && dy == 0)
        return 0.0;
    var instHdg: real := 90 * deg - tan(dy/dx);
    if (instHdg < 0.)
        instHdg += twoPi;
    if (instHdg > 2 * M_PI)
        instHdg += twoPi;
    var dx := x1 - x2;
    var dy := y1 - y2;
    if (dx == 0 && dy == 0)
        return 0.0;
    var instHdg0: real := 90 * deg - tan(dy/dx);
    if (instHdg0 < 0.)
        instHdg0 += 360 * deg;
    if (instHdg0 > 2 * M_PI)
        instHdg0 -= 360 * deg;
    var hdg_diff: real := normAngle(instHdg - instHdg0);
    var phi: real := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
method old_normAngle(angle: real) returns (res: real) {
        var twoPi: real := M_PI * 2;
        if (angle < -M_PI) {
			return angle + twoPi;
		}
		if (angle > M_PI) {
			return angle - twoPi;
		}
		return angle;
    }
// newV.dfy

method new_snippet(x0: real, y0: real, gspeed: real, x1: real, y1: real, x2: real, y2: real, dt: double) returns (res: double) {
    var twoPi: real := M_PI * 2;
    var deg: real := M_PI / 180;
    var gacc: real := 32.0;
    var dx: real := x0 - x1;
    var dy: real := y0 - y1;
    if (dx == 0 )//change:
        return 1.0;//change:
    var instHdg: real := 90 * deg - tan(dy/dx);
    if (instHdg < 0.)
        instHdg += twoPi;
    if (instHdg > 4 * M_PI)//change
        instHdg += twoPi;
    var dx := x1 - x2;
    var dy := y1 - y2;
    if (dx == 0 && dy == 0)
        return 0.0;
    var instHdg0: real := 90 * deg - tan(dy/dx);
    if (instHdg0 < 0.)
        instHdg0 += 360 * deg;
    if (instHdg0 > 2 * M_PI)
        instHdg0 -= 360 * deg;
    var hdg_diff: real := normAngle(instHdg - instHdg0);
    var phi: real := tan((hdg_diff * gspeed)/(gacc * dt));
    return phi / deg;
  }
method new_normAngle(angle: real) returns (res: real) {
        var twoPi: real := M_PI * 2;
        if (angle < -M_PI) {
			return angle + twoPi;
		}
		if (angle > M_PI) {
			return angle - twoPi;
		}
		return angle;
    }