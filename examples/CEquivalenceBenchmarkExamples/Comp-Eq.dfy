// oldV.dfy

method old_foo(a: int, b: int) returns (res: int) {
	if (a>b)
	  return 1;
	return 0;
}
method old_main() returns (res: int) {
	var x: int := 2;
	var y: int := 3;
	var z: int := old_foo(x,y);
	if (!z) {
		var tmp: int := y;
		  var y := x;
		  var x := tmp;
	  }
	return y;
}
// newV.dfy

method new_foo(a: int, b: int) returns (res: int) {
	if (a<b)
	  return 1;
	return 0;
}
method new_main() returns (res: int) {
	var x: int := 2;
	var y: int := 3;
	var z: int := new_foo(x,y);
	if (z) {
		var tmp: int := y;
		  var y := x;
		  var x := tmp;
	  }
	return y;
}
