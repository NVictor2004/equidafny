// oldV.dfy

method old_foo(a: int, b: int) returns (res: int) {
	var c: int := a+b;
	return c+3;
}
method old_main(void) returns (res: int) {
	return foo(5,900);
}
// newV.dfy

method new_foo(a: int, b: int) returns (res: int) {
	const var d: int := 3;
	var c: int := b+a;
	return c+d;
}
method new_main(void) returns (res: int) {
	return foo(5,900);
}