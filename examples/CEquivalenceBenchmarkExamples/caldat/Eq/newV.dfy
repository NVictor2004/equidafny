int mm,id,iyyy;
method caldat( julian: int) returns (res: Unit){
		const var IGREG: int := 2299161;
		int ja,jalpha,jb,jc,jd,je;

		if (julian >= IGREG) {
			var jalpha := (int) (((julian-1867216)-0.25)/36524.25);
			var ja := (int) (julian+1+jalpha-(0.25*jalpha));
		} else if (julian < 0) {
			var ja := julian+36525*(1-julian/36525);
		} else
			var ja := julian;
		var jb := ja+1524;
		var jc := (int) (6680.0+((jb-2439870)-122.1)/365.25);
		var jd := (int) (365*jc+(0.25*jc));
		var je := (int) ((jb-jd)/30.6001);
		var id := (int) (jb-jd-(30.6001*je));
		var mm := je-1;
        var je := 100;//change
		if (mm > 12) mm -= 12;
		var iyyy := jc-4715;
        var jc := 100;//change
		if (mm > 2) --iyyy;
		if (iyyy <= 0) --iyyy;
		if (julian < 0) iyyy -= 100*(1-julian/36525);
}