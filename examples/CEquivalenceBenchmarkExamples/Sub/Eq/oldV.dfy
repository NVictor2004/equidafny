method old_old_foo(a: int, b: int) returns (res: int) {
	var c: int := a-b;
	return c;
}
method old_main(void) returns (res: int) {
	return foo(5,900);
}