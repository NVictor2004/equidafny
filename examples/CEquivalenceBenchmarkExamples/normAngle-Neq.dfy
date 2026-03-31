// oldV.dfy

method old_snippet(angle: real) returns (res: real) {
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

method new_snippet(angle: real) returns (res: real) {
		var twoPi: real := M_PI * 2; 
		if (angle < -M_PI) {
		    return angle + M_PI ;//change
		}
		if (angle > M_PI) {
			return angle - M_PI ;//change
		}
		return angle;
	}
