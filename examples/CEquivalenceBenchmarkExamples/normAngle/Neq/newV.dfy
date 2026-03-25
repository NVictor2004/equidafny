function snippet(angle: double): double {
		var twoPi: double := M_PI * 2; 
		if (angle < -M_PI) {
		    return angle + M_PI ;//change
		}
		if (angle > M_PI) {
			return angle - M_PI ;//change
		}
		return angle;
	}