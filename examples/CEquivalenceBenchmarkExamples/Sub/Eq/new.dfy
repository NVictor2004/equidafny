method foo(a: int, b: int) returns (res: int) {
	var c: int := b-a;
	return c;
}
method main(void) returns (res: int) {
	return foo(900,5);
}