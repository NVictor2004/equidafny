// oldV.dfy

 var jd: int := 0;
 var frac: real := 0.0;
 int mm,id,iyyy;
method old_flmoon( n: int,  nph: int) returns (res: Unit)
{
		const var RAD: real := 3.141592653589793238/180.0;
		real am,as,c,t,t2,xtra;
		var c := n+nph/4.0;
		var t := c/1236.85;
		var t2 := t*t;
		var as := 359.2242+29.105356*c;
		var am := 306.0253+385.816918*c+0.010730*t2;
		var jd := 2415020+28*n+7*nph;
		var xtra := 0.75933+1.53058868*c+((1.178e-4)-(1.55e-7)*t)*t2;
		if (nph == 0 || nph == 2)
			xtra += (0.1734-3.93e-4*t)*sin(RAD*as)-0.4068*sin(RAD*am);
		else if (nph == 1 || nph == 3)
			xtra += (0.1721-4.0e-4*t)*sin(RAD*as)-0.6280*sin(RAD*am);
		else 
			printf("%s\n","nph is unknown in flmoon");
		var i := (int) (xtra >= 0.0 ? old_floor(xtra) : old_ceil(xtra-1.0));
		jd += i;
		var frac := xtra-i;
}
// newV.dfy

 var jd: int := 0;
 var frac: real := 0.0;
 int mm,id,iyyy;
method new_flmoon( n: int,  nph: int) returns (res: Unit)
{
		const var RAD: real := 3.141592653589793238/180.0;
		real am,as,c,t,t2,xtra;
		var c := n+nph/4.0;
		var t := c/1236.85;
		var t2 := t*t;
		var as := 359.2242+29.105356*c;
		var am := 306.0253+385.816918*c+0.010730*t2;
		var jd := 2415020+28*n+7*nph;
		var xtra := 0.75933+1.53058868*c+((1.178e-4)-(1.55e-7)*t)*t2;
		if (nph == 0 )//change
			xtra += (0.1734-3.93e-4*t)*sin(RAD*as)-0.4068*sin(RAD*am);
		else if (nph == 1 || nph == 3)
			xtra += (0.1721-4.0e-4*t)*sin(RAD*as)-0.6280*sin(RAD*am);
		else 
            var xtra := 0.0;
		var i := (int) (xtra >= 0.0 ? new_floor(xtra) : new_ceil(xtra-1.0));
		jd += i;
		var frac := xtra-i;
}
