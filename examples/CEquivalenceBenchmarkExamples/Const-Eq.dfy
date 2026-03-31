// oldV.dfy

method old_foo(a: int, b: int) returns (res: int) {
	var c: int := a+b;
	return c+3;
}

// newV.dfy

method new_foo(a: int, b: int) returns (res: int) {
	var d: int := 3;
	var c: int := b+a;
	return c+d;
}
