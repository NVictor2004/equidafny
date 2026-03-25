method new_foo(a: int, b: int) returns (res: int) {
	var c: int := b+a;
	return c;
}
method new_main(void) returns (res: int) {
	return foo(5,900);
}