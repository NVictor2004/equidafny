method new_foo(a: int, b: int) returns (res: int) {
	const var d: int := 3;
	var c: int := b+a;
	return c+d;
}
method new_main(void) returns (res: int) {
	return foo(5,900);
}