method old_foo(a: int, b: int) returns (res: int) {
	var c: int := a+b;
	return c+3;
}
method old_main(void) returns (res: int) {
	return foo(5,900);
}