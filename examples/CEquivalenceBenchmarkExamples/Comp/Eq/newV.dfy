method foo(a: int, b: int) returns (res: int) {
	if (a<b)
	  return 1;
	return 0;
}
method main(void) returns (res: int) {
	var x: int := 2;
	var y: int := 3;
	var z: int := foo(x,y);
	if (z) {
		var tmp: int := y;
		  y=x;
		  x=tmp;
	  }
	return y;
}