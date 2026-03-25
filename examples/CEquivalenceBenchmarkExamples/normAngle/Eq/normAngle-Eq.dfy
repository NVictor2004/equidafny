// oldV.dfy

method old_snippet(angle: double) returns (res: double) {
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

method new_snippet(angle: double) returns (res: double) {
		var temp: double := M_PI * 2; //change
		if (angle < -M_PI) {
			return angle + temp; //change
		}
		if (angle > M_PI) {
			return angle - temp; //change
		}
		return angle;
	}