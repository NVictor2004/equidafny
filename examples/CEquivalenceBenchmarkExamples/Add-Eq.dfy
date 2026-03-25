// oldV.dfy

method old_foo(a: int, b: int) returns (res: int) {
	var c: int := a+b;
	return c;
}
method old_main(void) returns (res: int) {
	return foo(5,900);
}
// newV.dfy

method new_foo(a: int, b: int) returns (res: int) {
	var c: int := b+a;
	return c;
}
method new_main(void) returns (res: int) {
	return foo(5,900);
}