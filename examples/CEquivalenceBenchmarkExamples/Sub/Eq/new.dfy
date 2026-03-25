function foo(a: int, b: int): int {
	var c: int := b-a;
	return c;
}
function main(void): int {
	return foo(900,5);
}