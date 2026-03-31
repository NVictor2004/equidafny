// oldV.dfy

method old_foo(a: int, b: int) returns (res: int) {
	var c: int := a+b;
	return c;
}

// newV.dfy

method new_foo(a: int, b: int) returns (res: int) {
	var c: int := b+a;
	return c;
}
